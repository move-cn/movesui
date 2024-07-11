## 使用 TreasuryCap 对象铸造 SuiFren Candy

在上一课中，我们创建了我们的第一个代币，并将 TreasuryCap 对象暂时转移给发送者（模块的部署者）。通过这个 TreasuryCap，该账户现在可以铸造 MYCOIN 代币：

```move
use std::string;
use sui::url;

fun init(otw: MYCOIN, ctx: &mut TxContext) {
    let (treasury_cap, metadata) = coin::create_currency(
        otw,
        9,
        b"MYC",
        b"MyCoin",
        b"My Coin description",
        option::some(url::new_unsafe(string::utf8(b"https://mycoin.com/logo.png"))),
        ctx,
    );
    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
}

entry fun mint(treasury_cap: &mut TreasuryCap<MYCOIN>, ctx: &mut TxContext) {
    let coins = coin::mint(treasury_cap, 1000, ctx);
    // Do something with the coins
}
```
有四个重要的点需要指出：

1. `coin::mint` 创建一个新的 Coin（钱包）对象。这意味着用户其他钱包中的现有余额不会改变。
2. 如果你记得，归属对象在作为参数传递给交易时会进行验证，并且只有它们的所有者才能这样做。在这种情况下，只有拥有 TreasuryCap<MYCOIN> 的账户可以调用 mint。
3. TreasuryCap 也有一个类型参数（MYCOIN）。这指定了国库上限管理的代币类型。
4. `coin::mint` 不需要指定 MyCoin 作为类型参数，因为编译器可以从 treasury_cap（类型为 TreasuryCap<MYCOIN>）中推断出来。

还需要注意的是，TreasuryCap 的类型是一个完全限定的类型名——例如，如果我们的模块地址是 `0x123`，那么它的类型是 `0x123::my_coin::MYCOIN`。这意味着如果其他人在他们的模块中创建了一个名为 MYCOIN 的结构体，即使结构体名称相同，也会被视为完全不同的代币。除了 `coin::mint`，开发人员还可以使用 `coin::mint_and_transfer` 直接铸造并转移到指定账户。
另一种常见的模式是在 init 函数中铸造初始分配的代币：

```move
use std::string;
use sui::url;

fun init(otw: MYCOIN, ctx: &mut TxContext) {
    let (treasury_cap, metadata) = coin::create_currency(
        otw,
        9,
        b"MYC",
        b"MyCoin",
        b"My Coin description",                       
        option::some(url::new_unsafe(string::utf8(b"https://mycoin.com/logo.png"))),
        ctx,
    );
    coin::mint_and_transfer(treasury_cap, 1000000, tx_context::sender(ctx), ctx);
    
    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
}
```
这允许开发人员创建初始数量的代币以供流通。他们可以选择实现一个铸币函数，以便以后创建更多的代币。