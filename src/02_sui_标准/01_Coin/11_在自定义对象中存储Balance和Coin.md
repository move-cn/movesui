## 在自定义对象中存储 Balance 和 Coin

如前几节课讨论的那样，Coin 和 Store 对象都具有 store 能力，可以嵌入到其他结构体中（在 Coin 的情况下，因为它是一个对象结构体，所以是“包装”）。

```move
struct MyObjectWithBalance has key {
    id: UID,
    balance: Balance<MYCOIN>,
}

struct MyObjectWithCoin has key {
    id: UID,
    coins: Coin<MYCOIN>,
}
```
正如前一课所讨论的那样，更常见的是存储 Balance 而不是 Coin。但为什么有人会在自定义结构体中存储 Balance 呢？这种结构最常见的原因是代币由智能合约或模块程序化地拥有。
例如，用户可以建立一个市场，用户可以列出他们自己的代币以与其他代币进行交易。在这种情况下，当买家出现时，我们不希望卖家也必须签署购买交易。
如果买家只需签署并交易自动完成——他们收到他们购买的代币，而支付的代币从他们的钱包（Coin 对象）中取出，这会更顺畅。

```move
struct Listing<phantom CoinType> has key {
    id: UID,
    seller: address,
    listed_coins: Balance<CoinType>,
    amount_asked: u64,
}

public fun buy_coins<CoinType>(listing: Listing<CoinType>, payment: Coin<SUI>): Balance<CoinType> {
    let Listing<CoinType> { id, seller, listed_coins, amount_asked } = listing;
    object::delete(id);
    assert!(coin::value(&payment) == amount_asked, EINSUFFICIENT_PAYMENT);
    transfer::public_transfer(payment, seller);
    listed_coins
}
```
在上述示例中，卖家可以创建一个列表，将他们想要出售的代币直接作为共享对象包含在内。列出的代币包含在列表对象中。一旦买家带着付款出现，列表可以被销毁以返回内部列出的代币作为 `Balance<CoinType>`。在 PTB（可编程交易块）中，卖家可以选择将 `Balance<CoinType>` 合并到他们拥有的任何同类型的 Coin 对象中。

请注意，`CoinType` 之前有一个 `phantom` 关键字。这是必需的，因为 `Listing` 的字段中没有一个直接是 `CoinType` 类型。我们看到的是 `Balance<CoinType>`，但 `CoinType` 在这里用作泛型而不是直接类型。简而言之，如果类型仅在一个或多个字段中用作泛型，则结构体需要使用 `phantom` 关键字。

还需注意的是，我们在这里使用泛型 `<CoinType>`，因此该系统可以适用于任何代币类型！