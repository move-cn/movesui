/*
将 Hat 更新为一个对象
使用动态对象字段来添加 Hat。记住，你需要在 color_hat 函数中添加一个交易上下文参数，以便创建 Hat 对象。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use std::string::String;
    use sui::dynamic_object_field;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    // 更新
    struct Hat has store {
        color: String,
    }

    // 更新
    public fun color_hat(sui_fren: &mut SuiFren, color: String) {
        if (dynamic_field::exists_(&sui_fren.id, string::utf8(HAT_KEY))) {
            let hat: &mut Hat = dynamic_field::borrow_mut(&mut sui_fren.id, string::utf8(HAT_KEY));
            hat.color = color;
        } else {
            dynamic_field::add(&mut sui_fren.id, string::utf8(HAT_KEY), Hat { color });
        }
    }
}