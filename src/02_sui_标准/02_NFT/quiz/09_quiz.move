/*
更新 init 函数，为 SuiFren NFT 也创建一个 Display 对象。
Display 对象只需打印出 generation 和 birthdate，使用以下键/格式：
- generation: "SuiFren generation: {generation}"
- birthdate: "Born on {birthdate}"
为了简化操作，Display 对象将被转移到模块部署者。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use std::string::String;
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use nft_protocol::mint_cap;
    use nft_protocol::mint_event;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: Attributes,
    }

    struct SUIFREN has drop {}
    
    struct Witness has drop {}

    fun init(otw: SUIFREN, ctx: &mut TxContext) {
        let (collection, mint_cap) =
            collection::create_with_mint_cap<SUIFREN, SuiFren>(&otw, option::none(), ctx);
        let delegated_witness = witness::from_witness(Witness {});
        
        collection::add_domain(
            delegated_witness,
            &mut collection,
            display_info::new(
                string::utf8(b"SuiFrens"),
                string::utf8(b"A collection of SuiFrens who hangout together"),
            ),
        );
        transfer::public_share_object(collection);
        transfer::public_share_object(mint_cap);
    }
}

