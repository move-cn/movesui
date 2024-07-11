## SuiFren Candy - 创建一种新的 Coin 类型

在 Sui Move 中，开发人员只需调用一个模块（智能合约）来创建和管理他们的代币。为了区分不同开发人员创建的不同类型的代币，Coin 使用了泛型（类型参数）：

```move
/// 获取代币余额的不可变引用。
public fun balance<T>(coin: &Coin<T>): &Balance<T> {
    &coin.balance
}
```
上述函数用于检查用户所拥有的代币钱包对象的余额。注意，函数名称末尾有一个 <T>。这是一个类型参数，指定函数是为哪个代币钱包调用的，可以是 Coin<MYCOIN> 或 Coin<YourCoin>。
为了创建代币，开发人员首先需要在他们的模块中将这种 Coin 类型定义为一个结构体：

```move
module my_coin::my_coin {
    struct MYCOIN has drop {}
}
```

这类似于 SUI 代币的定义方式。
然后，开发人员可以通过调用 `coin::create_currency` 创建新的代币，通常作为 init 函数的一部分，因为你需要一个 Coin 类型的一次性见证（otw）对象（在这种情况下为 MYCOIN）：

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
```
`coin::create_currency` 返回一个元数据对象，用于存储关于代币的信息：符号（Coin 将显示的缩写）、名称、描述和 logo URL。这允许链外组件（如 Web UI）查找并显示这些信息。开发人员可以选择冻结元数据对象，这样名称/符号等就不能再更改，或者保留它的所有权并转移到一个账户以供以后管理（更多内容将在后续课程中介绍）。

`coin::create_currency` 还返回一个 TreasuryCap 对象，可用于管理代币。我们将在后续课程中详细讨论这个内容。

现在代币已经创建，开发人员可以在调用代币函数时使用 NYCOIN 作为 Coin 类型参数，例如：

```move
public fun my_coin_balance(coin: &Coin<MYCOIN>): &Balance<MYCOIN> {
    // <MYCOIN> is technically not required here as the type can be inferred.
    // It's just included explicitly for demonstration purposes.
    coin::balance<MYCOIN>(coin)
}
```
