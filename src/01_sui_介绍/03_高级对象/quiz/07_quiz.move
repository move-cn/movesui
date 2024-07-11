/*
将 GiftBox 结构体更新为使用 ObjectBag 而不是单个 SuiFren 类型的字段。

1. 更新 wrap_fren 以适应 ObjectBag。
2. 添加一个 wrap_hat 入口函数，将 Hat 添加到 GiftBox 的 ObjectBag 中。
3. ObjectBag 应使用索引作为键（第一个对象的索引为 0，第二个对象的索引为 1，依此类推）。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren, Hat};
    use sui::tx_context;
    use sui::object_bag::{Self, ObjectBag};

    // 更新
    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    // 更新
    entry fun wrap_fren(fren: SuiFren, ctx: &mut TxContext) {
        let gift_box = GiftBox {
            id: object::new(ctx),
            inner: fren,
        };
        transfer::transfer(gift_box, tx_context::sender(ctx));
    }

    // 这里添加新函数
}