/*
使用 ObjectBag 仍然更好，但仅仅为了练习：

1. 将 GiftBox 中的 ObjectBag 替换为两个独立的 ObjectTable，一个用于 SuiFren，一个用于 Hat。键是字符串 u64（索引）。
2. 更新所有函数以适应 ObjectTable。
*/
module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;
    use sui::object_table::{Self, ObjectTable};

    // 更新
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
    }

    entry fun wrap_hat(gift_box: &mut GiftBox, hat: Hat) {
        let index = object_bag::length(&gift_box.object_bag);
        object_bag::add(&mut gift_box.object_bag, index, hat);
    }
}