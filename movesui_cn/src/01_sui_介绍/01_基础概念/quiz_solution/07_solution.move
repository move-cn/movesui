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
            num_frens: (DEFAULT_NUM_FRIENDS as u64),
        };
        transfer::share_object(config);
    }
}
