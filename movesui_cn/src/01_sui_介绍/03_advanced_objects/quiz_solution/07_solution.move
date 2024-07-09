module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;
    use sui::object_bag::{Self, ObjectBag};

    struct GiftBox has key {
        id: UID,
        object_bag: ObjectBag,
    }

    entry fun wrap_fren(fren: SuiFren, ctx: &mut TxContext) {
        let gift_box = GiftBox {
            id: object::new(ctx),
            object_bag: object_bag::new(ctx),
        };
        let index = object_bag::length(&gift_box.object_bag);
        object_bag::add(&mut gift_box.object_bag, index, fren);
        transfer::transfer(gift_box, tx_context::sender(ctx));
    }

    entry fun wrap_hat(gift_box: &mut GiftBox, hat: Hat) {
        let index = object_bag::length(&gift_box.object_bag);
        object_bag::add(&mut gift_box.object_bag, index, hat);
    }
}