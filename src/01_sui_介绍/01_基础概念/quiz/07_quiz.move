/*
以下的 init 函数目前将 AdminCap 中的 num_frens 设置为常量（固定值）类型为 u16 的 DEFAULT_NUM_FRIENDS，尽管 num_frens 的类型为 u64。这将因类型不匹配而无法编译。请修复此问题。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    const DEFAULT_NUM_FRIENDS: u16 = 1000;

    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    fun init(ctx: &mut TxContext) {
        let config = AdminCap {
            id: object::new(ctx),
            num_frens: DEFAULT_NUM_FRIENDS,
        };
        transfer::share_object(config);
    }
}