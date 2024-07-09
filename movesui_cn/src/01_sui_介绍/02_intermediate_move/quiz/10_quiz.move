/*
在 sui_fren 模块中添加一个见证结构体和一个 init 函数，该函数：

将见证对象作为参数，并创建一个发布者对象。
将发布者结构体转移给发送者（与部署账户相同）。请注意，您需要使用正确的转移函数（在 transfer 和 public_transfer 之间选择哪个？）
*/

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

    // 这里添加见证结构体

    // 这里添加 init 函数
}