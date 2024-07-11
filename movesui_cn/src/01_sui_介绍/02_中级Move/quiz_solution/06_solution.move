module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    entry fun open_box(gift_box: GiftBox, ctx: &TxContext) {
        let GiftBox {id, inner} = gift_box;
        object::delete(id);
        transfer::public_transfer(inner, tx_context::sender(ctx));
    }
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}