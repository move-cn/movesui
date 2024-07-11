/*
在 sui_fren 模块中创建一个新的结构体 Candy，该结构体有一个类型为 u64 的字段 value，并在 GiftBox 中添加一个类型为 Candy 向量的新字段 candies。目前，Candy 是一个非对象结构体，我们将在后续课程中将糖果喂给 Fren 以升级它们。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren, Candy};
    use sui::tx_context;

    // 更新
    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }
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

    // 这里添加新的结构体
}