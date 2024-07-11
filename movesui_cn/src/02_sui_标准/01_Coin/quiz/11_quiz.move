/*
1. 更新我们在前一课中创建的 GiftBox 对象，使其包含一个 SuiFren 和一定数量的糖果（代币），即 Balance<CANDY>。
2. 更新 create_gift 函数以在礼品盒中生成指定数量的糖果。
3. 添加一个 open_gift 函数，该函数销毁礼品盒并将 SuiFren 和糖果发送给发送者。
*/

module 0x123::fren_summer {
    use sui::object::{Self, UID};
    use 0x123::sui_fren::{Self, SuiFren};
    use sui::tx_context;

    struct CANDY has drop {}

    struct GiftBox has key {
        id: UID,
        sui_fren: SuiFren,
    }

    struct CandyTreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<CANDY>,
    }

    entry fun create_gift(holder: &mut CandyTreasuryCapHolder, generation: u64, birthdate: u64, attributes: vector<String>, num_coins: u64, ctx: &mut TxContext) {
        let fren = sui_fren::create(generation, birthdate, attributes, ctx);
        let gift_box = GiftBox {
            id: object::new(ctx),
            inner: fren,
        };
        transfer::transfer(gift_box, tx_context::sender(ctx));
    }
}