/*
1. 添加一个新的公共函数 get_attributes，该函数接受一个 sui_fren 对象并返回其属性。

2. 编写一个新的公共函数 update_attributes 以允许更改 SuiFren 的 属性列表。该函数应接受两个参数：要修改的 sui_fren 对象和新的属性列表。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    // 这里添加新函数
}
