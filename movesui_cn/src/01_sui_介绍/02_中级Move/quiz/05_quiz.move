/*
想象一下，用户可以在假日季节的特定周内用他们的 SuiFren 创建礼品盒并赠送给朋友。然而，我们希望限制每周可以创建的礼物数量（每周的限制可以不同）。为此，我们将：

1. 创建一个新的对象结构体 GiftWeekConfig，它包含 id 字段和另一个类型为 u64 的 limit 字段。
2. 创建一个新的入口函数 create_week，该函数接收一个 limit 参数，并创建和冻结一个 GiftWeekConfig 对象。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    // 这里添加新结构体

    // 这里添加新函数
}