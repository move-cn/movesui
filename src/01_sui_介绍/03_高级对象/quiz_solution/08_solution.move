module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;
    use sui::object_table::{Self, ObjectTable};

    struct GiftBox has key {
        id: UID,
        sui_frens: ObjectTable<u64, SuiFren>,
        hats: ObjectTable<u64, Hat>,
    }

    entry fun wrap_fren(fren: SuiFren, ctx: &mut TxContext) {
        let gift_box = GiftBox {
            id: object::new(ctx),
            sui_frens: object_table::new(ctx),
            hats: object_table::new(ctx),
        };
        let index = object_table::length(&gift_box.sui_frens);
        object_table::add(&mut gift_box.sui_frens, index, fren);
    }

    entry fun wrap_hat(gift_box: &mut GiftBox, hat: Hat) {
        let index = object_table::length(&gift_box.hats);
        object_table::add(&mut gift_box.hats, index, hat);
    }
}