/*
让 我们来把 GiftBox 变得更有趣一些。与其包装一个现有的 SuiFren，不如在创建 GiftBox 时随机创建一个 SuiFren！

在 sui_fren 模块中添加一个 create_random 公共友元函数，该函数生成一个具有随机生成的 power 的 SuiFren。create_random 接受一个上下文参数并返回创建的 SuiFren 对象。
在 fren_summer 模块中添加一个新的入口函数 create_gift，用于创建一个 GiftBox，调用 sui_fren::create_random 创建包装的 SuiFren 对象，并将其发送给交易的发送者。
只有 fren_summer::create_gift 可以调用 sui_fren::create_random。
*/

module 0x123::fren_summer {
    use 0x123::sui_fren;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    // 这里添加新函数
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;
    
    struct SuiFren has key {
        id: UID,
        power: u64,
    }

    // 这里添加新函数
}