/*
在 sui_fren 模块中添加一个具有 store 能力的新结构体 Hat。Hat 结构体有一个类型为 String 的字段 color。我们将在后面添加更多字段。

添加一个新的公共函数 color_hat，该函数接受一个名为 sui_fren 的 SuiFren 的可变引用和一个类型为 String 的 color。
color_hat 应该在 SuiFren 没有帽子时添加一个帽子，如果已经有帽子则更新其颜色。
你可以使用 string::utf8(HAT_KEY) 作为动态字段键。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use std::string::String;
    use sui::dynamic_field;

    const HAT_KEY: vector<u8> = b"HAT";
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    // 这里添加新结构体

    // 这里添加新函数
}