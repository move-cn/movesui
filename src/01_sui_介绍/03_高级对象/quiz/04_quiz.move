/*
重写 color_hat 函数，将 Hat 对象转移到 SuiFren 对象，而不是使用动态对象字段。
请注意，如果帽子已经存在，我们不能轻易更改其颜色而不添加 Receiving<Hat> 到 color_hat 函数中，这样做没有意义，并且与 SuiFren 没有帽子的情况相冲突。
相反，添加一个单独的公共函数 update_hat_color，用于更新现有帽子的颜色。
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

    struct Hat has key, store {
        id: UID,
        color: String,
    }

    // 更新
    public fun color_hat(sui_fren: &mut SuiFren, color: String, ctx: &mut TxContext) {
        let hat = Hat {
            id: object::new(ctx),
            color,
        };
        dynamic_object_field::add(&mut sui_fren.id, string::utf8(HAT_KEY), hat);
    }
}