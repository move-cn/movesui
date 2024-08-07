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


    // Add function get_num_frens here
    fun get_num_frens(admin_cap: &AdminCap): u64 {
        admin_cap.num_frens
    }
}
