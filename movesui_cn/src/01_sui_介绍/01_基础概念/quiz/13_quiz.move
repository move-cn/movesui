/*
发出两个事件：

1. MintEvent：包含新铸造的 SuiFren 对象的 id。
2. BurnEvent：包含要删除的 SuiFren 的 id。

提示：不要忘记导入相关的模块！
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

    // 这里定义新事件

    public fun mint(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        let sui_fren = SuiFren {
            id: object::new(ctx),
            generation,
            birthdate,
            attributes,
        };
        transfer::transfer(sui_fren, tx_context::sender(ctx));
    }

    public fun burn(sui_fren: SuiFren) {
        let SuiFren {
            id,
            generation: _,
            birthdate: _,
            attributes: _,
        } = sui_fren;
        object::delete(id);
        // 这里发出事件
    }
}


