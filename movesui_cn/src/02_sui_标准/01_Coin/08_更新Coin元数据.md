## 更新 Coin 元数据

当我们之前创建 MyCoin 时，我们冻结了返回的元数据对象。这将不允许将来对元数据（小数位数/符号/名称/描述/logo URL）进行任何更改。

说到小数位数，我们从未真正解释过它的作用。小数位数通常用于代币/代币，以减少舍入误差。大多数智能合约语言，包括 Move，都没有分数，所有数学运算都是基于整数的。这意味着在 Move 中，5 / 2 = 2，导致舍入误差为1。如果没有小数位数，人们将会损失大量资金。加密货币中通常使用至少6位小数，有时可以高达18位（1个代币 = 10^18单位）。在大多数情况下，9位小数足以使舍入误差小到用户可以忽略不计。

回到元数据对象，如果你认为将来可能会想要更改代币的元数据，那么你不应该冻结它，而应该将其转移到一个管理员账户进行保管。将来，你可以利用 coin 模块中的不同函数来更新你想要的元数据：

```move
/// 更新`CoinMetadata`里coin的名字
public entry fun update_name<T>(
    _treasury: &TreasuryCap<T>, metadata: &mut CoinMetadata<T>, name: string::String
) {
    metadata.name = name;
}

/// 更新`CoinMetadata`里coin的符号
public entry fun update_symbol<T>(
    _treasury: &TreasuryCap<T>, metadata: &mut CoinMetadata<T>, symbol: ascii::String
) {
    metadata.symbol = symbol;
}

/// 更新`CoinMetadata`里coin的描述
public entry fun update_description<T>(
    _treasury: &TreasuryCap<T>, metadata: &mut CoinMetadata<T>, description: string::String
) {
    metadata.description = description;
}

/// 更新`CoinMetadata`里coin的链接
public entry fun update_icon_url<T>(
    _treasury: &TreasuryCap<T>, metadata: &mut CoinMetadata<T>, url: ascii::String
) {
    metadata.icon_url = option::some(url::new_unsafe(url));
}
```
请注意，小数位数（decimals）是一个特殊情况，没有相应的更新函数。这是因为小数位数是代币的一个基本属性，如果被更新，会改变每个人的余额。因此，为了安全性和简便性，Sui 的 Coin 标准不允许修改小数位数。

要调用更新函数，例如 `coin::update_symbol`，调用者需要访问 TreasuryCap 和 metadata 对象。
请注意，TreasuryCap 和 Metadata 结构体都有 store 能力，因此我们可以将它们存储在某个地方，以便以后可以进行编程访问和修改：

```move
use std::string;
use sui::url;

struct MYCOIN has drop {}

struct CoinDataHolder has key {
    id: UID,
    treasury_cap: TreasuryCap<MYCOIN>,
    metadata: CoinMetadata<MYCOIN>,
}

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
    
    let treasury_cap_holder = TreasuryCapHolder {
        id: object::new(ctx),
        treasury_cap,
        metadata,
    };
    transfer::share_object(treasury_cap_holder);
}

entry fun update_symbol(holder: &mut CoinDataHolder, new_symbol: String) {
    let metadata = &mut holder.metadata;
    let treasury_cap = &holder.treasury_cap;
    coin::update_symbol(treasury_cap, metadata, new_symbol);
}
```
在上面的例子中，我们将 TreasuryCap 和 Metadata 对象都包装在一个共享对象中，以便以后任何人都可以访问该对象来更新代币的元数据。在实际应用中，开发人员可以添加逻辑，要求发送者是特定的管理员地址，以确保用户不会随意更新代币元数据。