/*
更新 `init` 函数，为所有 SuiFrens 收取 2% 的版税。所有版税应发送到 `sui_fren` 模块发布者。
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

        // 这里添加版税逻辑

        transfer::public_share_object(collection);
        transfer::public_share_object(mint_cap);
    }
}
