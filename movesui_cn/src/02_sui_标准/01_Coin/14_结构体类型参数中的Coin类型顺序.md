## 结构体类型参数中的 Coin 类型顺序

在之前的市场示例中，我们创建了类型为 `Listing<ListedCoin, PaymentCoin>` 的市场列表。然后 `buy_coins` 函数需要 `Listing<ListedCoin, PaymentCoin>` 作为参数，以知道买家想要从哪个列表中购买。

```move
struct Listing<phantom ListedCoin, phantom PaymentCoin> has key {
    id: UID,
    seller: address,
    listed_coins: Balance<ListedCoin>,
    amount_asked: u64,
}

public fun buy_coins<ListedCoin, PaymentCoin>(listing: Listing<ListedCoin, PaymentCoin>, payment: Coin<PaymentCoin>): Balance<CoinType> {
    let Listing<ListedCoin, PaymentCoin> { id, seller, listed_coins, amount_asked } = listing;
    object::delete(id);
    assert!(coin::value(&payment) == amount_asked, EINSUFFICIENT_PAYMENT);
    transfer::public_transfer(payment, seller);
    listed_coins
}
```

假设有人为 `Listing<MyCoin, SUI>` 创建了一个列表，但买家弄错了顺序，将列表指定为 `Listing<Sui, MyCoin>`。那么会发生什么呢？当这个交易发送到 Sui 网络时，验证层会报错，因为在提供的相同地址上，`Listing<SUI, MyCoin>` 是无效的（SUI 是列出的代币，而 MyCoin 是支付代币）。不必担心这会意外指向另一个 SUI 的列表，因为每个对象的地址是唯一的，并且只能有一种类型。如果另一个卖家确实创建了 `Listing<SUI, MyCoin>`，这个列表对象的地址会有所不同。

这是用户尤其是在复杂市场/交易所中常遇到的一个常见问题，因为这些市场/交易所具有许多不同类型的列表，涉及不同的代币对。与我们上面举的 `Listing` 示例不同，在 Sui 的大多数交易所中，代币的顺序实际上对核心对象本身并不重要。

```move
struct Market<phantom Coin1, phantom Coin2> has key {
    id: UID,
    reserves_1: Balance<Coin1>,
    reserves_2: Balance<Coin2>,
}
```
在这个市场中，Coin1 和 Coin2 具有相似的角色——买家可以用 Coin2 购买 Coin1，或者用 Coin1 购买 Coin2。在这里，顺序技术上并不重要，但不幸的是，当 Market 对象被创建时，我们仍然需要选择哪个 Coin 是第一个类型（Coin1）。在后台，对象仍然按照 Market<Coin1, Coin2> 的顺序创建。因此，当用户与这个市场互动时，他们仍然需要按照创建时的正确顺序指定代币。

为了让用户更容易使用，一个解决方案是确保在创建 Market 对象时，Coin1 和 Coin2 也按字母顺序排序。然而，由于缺乏字符串比较功能，这在 Sui Move 中目前还不容易实现。