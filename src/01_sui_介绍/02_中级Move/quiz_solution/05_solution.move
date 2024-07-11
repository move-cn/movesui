module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;

    struct GiftBox has key {
        id: UID,
        inner: SuiFren,
    }

    struct GiftWeekConfig has key {
        id: UID,
        limit: u64,
    }

    entry fun create_week(limit: u64, ctx: &mut TxContext) {
        let gift_week_config = GiftWeekConfig {
            id: object::new(ctx),
            limit,
        };
        transfer::freeze_object(gift_week_config);
    }
}