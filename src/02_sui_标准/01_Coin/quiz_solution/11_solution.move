module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;
    use sui::coin::{Self, Coin};

    struct CANDY has drop {}

    struct GiftBox has key {
        id: UID,
        sui_fren: SuiFren,
        candies: Balance<CANDY>,
    }

    struct CandyTreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<CANDY>,
    }

    entry fun create_gift(holder: &mut CandyTreasuryCapHolder, generation: u64, birthdate: u64, attributes: vector<String>, num_coins: u64, ctx: &mut TxContext) {
        let treasury_cap = &mut holder.treasury_cap;
        let fren = sui_fren::create(generation, birthdate, attributes, ctx);
        let gift_box = GiftBox {
            id: object::new(ctx),
            inner: fren,
            candies: coin::mint(treasury_cap, amount, ctx),
        };
        transfer::transfer(gift_box, tx_context::sender(ctx));
    }

    entry fun open_gift(gift_box: GiftBox, ctx: &mut TxContext) {
        let GiftBox { id, sui_fren, candies } = gift_box;
        object::delete(id);
        transfer::public_transfer(sui_fren, tx_context::sender(ctx));
        let candy_coins = coin::from_balance(candies, ctx);
        transfer::public_transfer(candy_coins, tx_context::sender(ctx));
    }
}