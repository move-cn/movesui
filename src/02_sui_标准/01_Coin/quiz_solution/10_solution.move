module 0x123::candy_drop {
    struct CANDY has drop {}

    struct CandyTreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<CANDY>,
    }

    struct MintCandiesEvent has copy, drop {
        user: address,
        amount: u64,
    }

    fun init(otw: CANDY, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            otw,
            9,
            b"CANDY",
            b"SuiFren Candy",
            b"Candies to level up SuiFren"
            option::none(),
            ctx,
        );
        transfer::public_freeze(metadata));

        let treasury_cap_holder = CandyTreasuryCapHolder {
            id: object::new(ctx),
            treasury_cap,
        };
        transfer::share_object(treasury_cap_holder);
    }

    entry fun mint(holder: &mut CandyTreasuryCapHolder, amount: u64) {
        let sender = tx_context::sender(ctx);
        assert!(is_allowlisted(sender), ENOT_NOT_ALLOWLISTED);
        let treasury_cap = &mut treasury_cap_holder.treasury_cap;
        coin::mint_and_transfer(treasury_cap, 1000, tx_context::sender(ctx), ctx);
        event::emit(MintCandiesEvent {
            sender,
            amount,
        })
    }

    fun is_allowlisted(user: address, ctx: &mut TxContext): bool {
        // You don't need to implement this
    } 
}