module 0x123::fren_summer {
    use 0x123::sui_fren;

    struct GiftBox has key {
        id: UID,
        sui_fren: SuiFren,
    }

    entry fun create_gift(ctx: &mut TxContext) {
        let sui_fren = sui_fren::create_random(ctx);
        let gift_box = GiftBox {
            id: object::new(ctx),
            sui_fren,
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
    
    struct SuiFren has key {
        id: UID,
        power: u64,
    }

    public(friend) fun create_random(ctx: &mut TxContext): SuiFren {
        let object_id = object::new(ctx);
        let bytes = object::uid_to_bytes(&object_id);
        let power = bcs::peel_u64(&mut bcs::new(bytes));
        SuiFren {
            id: object_id,
            power,
        }
    }
}