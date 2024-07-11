/*
定创建一个名为 mint 的新公共函数，该函数接受四个参数并返回一个 SuiFren 对象：

1. 类型为 u64 的 generation 和 birthdate
2. 类型为 vector<String> 的 attributes
3. 类型为 &mut TxContext 的 ctx
提示：当结构体字段名称和值具有相同名称时，可以使用以下简化形式：

struct MyStruct {
   value: u64,
}
let value = 1;
MyStruct {
   value,
}

*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    // 这里添加新函数