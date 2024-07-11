module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::string::String;
    use std::vector;
    use sui::event;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct CANDY has drop {}

    struct CandyTreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<CANDY>,
        metadata: CoinMetadata<CANDY>,
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
        transfer::public_transfer(metadata, tx_context::sender(ctx));

        let treasury_cap_holder = CandyTreasuryCapHolder {
            id: object::new(ctx),
            treasury_cap,
        };
        transfer::share_object(treasury_cap_holder);
    }

    entry fun update_icon_url(holder: &mut CandyTreasuryCapHolder, new_icon_url: String) {
        let metadata = &mut holder.metadata;
        let treasury_cap = &holder.treasury_cap;
        coin::update_icon_url(treasury_cap, metadata, new_icon_url);
    }
}