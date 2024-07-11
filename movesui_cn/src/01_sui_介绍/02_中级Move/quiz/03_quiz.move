/*
为 SuiFren 赋予 store 能力，并在 fren_summer 模块中定义一个新的 GiftBox 对象结构体，它有一个类型为 SuiFren 的字段inner。GiftBox 结构体不需要 store 能力，因为它不需要成为其他结构体的一部分
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};

    // 这里添加新结构体

    entry fun open_box(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        sui_fren::mint(generation, birthdate, attributes, ctx);
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
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}