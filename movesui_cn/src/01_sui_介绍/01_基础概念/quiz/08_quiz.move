/*
定义一个新的 SuiFren 对象结构体，该结构体具有以下字段：类型为 u64 的 generation，类型为 u64 的 birthdate，以及作为字符串向量的 attributes。不要忘记添加 vector 的 import 语句。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    
    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    // 这里添加新的 SuiFren 结构体
}