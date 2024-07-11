module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    entry fun create_gift(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        let fren = sui_fren::create(generation, birthdate, attributes, ctx);
        let gift_box = GiftBox {
            id: object::new(ctx),
            inner: fren,
        };
        transfer::transfer(gift_box, tx_context::sender(ctx));
    }

    entry fun wrap_fren(fren: SuiFren, ctx: &mut TxContext) {
        let gift_box = GiftBox {
            id: object::new(ctx),
            inner: fren,
        };
        transfer::transfer(gift_box, tx_context::sender(ctx));
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

    public(friend) fun create(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext): SuiFren {
        SuiFren {
            id: object::new(ctx),
            generation,
            birthdate,
            attributes,
        }
    }

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