module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

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
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}