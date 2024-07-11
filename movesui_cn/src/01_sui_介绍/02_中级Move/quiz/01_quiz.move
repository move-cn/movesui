/*
目前，任何人都可以铸造Sui Fren。让我们：

1. 将铸造函数 mint 设为仅限 friend 调用
2. 添加一个新模块 0x123::fren_summer，其中包含一个公共函数 open_box，其签名与 sui_fren::mint 相同（暂时如此），并在其中调用 sui_fren::mint。我们将在接下来的课程中解释这个函数将被用于什么目的。
*/

// 这里添加新模块和函数

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;

    // 这里添加 friend 显示声明（若有）
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct MintEvent has copy, drop {
        id: ID,
    }

    // 更新
    public fun mint(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        let uid = object::new(ctx);
        let id = object::uid_to_inner(&uid);
        let sui_fren = SuiFren {
            id: uid,
            generation,
            birthdate,
            attributes,
        };
        transfer::transfer(sui_fren, tx_context::sender(ctx));
        event::emit(MintEvent {
            id,
        });
    }
}