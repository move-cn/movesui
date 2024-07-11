/*
更新 fren_summer 模块中的 open_box 函数，以销毁 GiftBox 对象，取出内部的 SuiFren 并将其转移给发送者。不要忘记更新能力。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    entry fun open_box(gift_box: GiftBox) {
        
    }
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};

    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}