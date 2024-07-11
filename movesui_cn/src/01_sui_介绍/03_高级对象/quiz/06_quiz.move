/*
我们希望扩展 Hat，以添加一个类型为 String 的 description 字段和一个类型为 u64 的 duration 字段。

1. 添加一个新的扩展结构体，名为 HatExtension1。
2. 添加一个新的公共函数 extend_hat，该函数接受 SuiFren、description 和 duration，并在 SuiFren 的 Hat 存在的情况下对其进行扩展。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use std::string::String;
    use sui::dynamic_field;
    use sui::dynamic_object_field;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    const HAT_KEY: vector<u8> = b"HAT";

    struct Hat has key, store {
        id: UID,
        color: String,
    }

    // 这里添加新结构体

    // 这里添加新函数
}