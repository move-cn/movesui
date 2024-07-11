/*
让我们添加几个新函数：

1. 在 `sui_fren` 模块中添加一个 friend 函数 `create`，该函数具有与 `mint` 相同的参数，并创建并返回一个 SuiFren。
2. 在 `fren_summer` 模块中添加一个新的入口函数 `create_gift`，该函数具有与 `sui_fren::create` 相同的参数，调用 `sui_fren::create` 创建一个 SuiFren，将其放入 GiftBox，并将 GiftBox 发送给发送者。
3. 在 `fren_summer` 模块中添加一个新的入口函数 `wrap_fren`，该函数接受一个名为 `fren` 的现有 SuiFren 参数，将其包装在 GiftBox 中，并将 GiftBox 发送给发送者。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    // 这里添加新函数
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;

    friend 0x123::fren_summer;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    // 这里添加新函数

    public(friend) fun mint(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        let sui_fren = SuiFren {
            id: object::new(ctx),
            generation,
            birthdate,
            attributes,
        };
        transfer::transfer(sui_fren, tx_context::sender(ctx));
    }
}