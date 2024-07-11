/*
1. 添加一个新的事件 DeleteFrenEvent，它只包含被删除的 SuiFren NFT 的 ID（类型为 ID），命名为 fren_id。
   查看 https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/packages/sui-framework/sources/object.move 了解如何从对象的 UID 字段创建 ID。
2. 添加一个新的入口函数 delete_fren，用于删除 SuiFren NFT。
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
    }

    struct SUIFREN has drop {}
    
    struct Witness has drop {}

    // 这里添加新的事件

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

        let publisher = package::claim(otw, ctx);
        let display_object = display::new<SuiFren>(&publisher, ctx);
        display::add_multiple(
            &mut display,
            vector[
                utf8(b"generation"),
                utf8(b"birthdate"),
            ],
            vector[
                utf8(b"SuiFren generation: {generation}"),
                utf8(b"Born on {birthdate}"),
            ],
        );
        display::update_version(&mut display);
        transfer::public_transfer(display, tx_context::sender(ctx));
    }

    // 这里添加新函数
}
