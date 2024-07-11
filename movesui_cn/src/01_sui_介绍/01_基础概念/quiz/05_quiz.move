/*
添加一个新的函数 get_num_frens，该函数接受一个类型为 &AdminCap 对象的参数 admin_cap，并返回 num_frens 的值。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;


    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    fun init(ctx: &mut TxContext) {
        let admin_cap = AdminCap {
            id: object::new(ctx),
            num_frens: 1000,
        };
        transfer::share_object(admin_cap);
    }


    // 这里添加 get_num_frens 函数
}