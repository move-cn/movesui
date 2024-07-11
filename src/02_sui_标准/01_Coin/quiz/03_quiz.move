/*
在 sui_fren 模块中添加一个 mint_candy 入口函数，用于铸造糖果（Candy）代币并发送给发送者。
现在只有 TreasuryCap<Candy> 的所有者可以调用该函数。
铸币函数应接受国库上限对象、类型为 u64 的数量以及任何其他所需的系统对象参数。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct CANDY has drop {}

    fun init(otw: CANDY, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            otw,
            9,
            b"CANDY",
            b"SuiFren Candy",
            b"Candies to level up SuiFren"
            option::none(),
            ctx,
        );
        transfer::public_transfer(metadata, tx_context::sender(ctx));
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    // 这里添加铸造函数
}