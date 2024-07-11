## Kiosk 标准 - 交易NFTs

### NFT市场简介
NFT（非同质化代币）市场是NFT生态系统中的重要枢纽，能够买卖和交易独特的数字资产。它们的重要性体现在以下几个关键方面：

1. 可访问性：NFT市场使人们能够轻松进入数字收藏品和独特内容的世界。
2. 可发现性：这些平台为用户提供了工具，使他们能够找到符合自己兴趣的NFT，促进探索和连接。
3. 信任和安全：区块链技术确保了透明性、真实性和安全的交易。
4. 二级销售：NFT市场促进转售，使创作者能够赚取版税，投资者也有可能获利。
5. 社区和互动：它们围绕NFT建立社区，促进互动和协作。
6. 创作者的货币化：艺术家和创作者可以直接在这些平台上将作品变现。

### Kiosk - Sui的市场标准
Sui Kiosk是一个对象市场的标准，支持上市和销售。它作为Sui框架的一部分，部署在0x2，拥有许多强大的功能，可以很好地支持NFT交易。

Kiosk模块可以在这里找到，提供以下功能（也适用于非NFT对象）：

- 创建和管理新的NFT市场（一个kiosk）
- 转移NFT市场的所有权
- 上市和下架NFT
- 购买上市的NFT
- TransferPolicy允许NFT类型所有者（创作者）为其NFT的每次交易定义自定义规则，包括版税执行（我们在之前的课程中看到的OriginByte）和白名单

Kiosk目前仅支持使用SUI代币作为支付方式，但开发者可以部署自己的Kiosk版本，以支持其他代币。

### 在Kiosk上交易
首先需要创建一个kiosk：

```move
struct KioskManagement has key {
    id: UID,
    owner_cap: KioskOwnerCap,
}

public fun create_kiosk(ctx: &mut TxContext) {
    let (kiosk, owner_cap) = kiosk::new(ctx);
    transfer::public_share_object(kiosk);
    let kiosk_management = KioskManagement {
        id: object::new(ctx),
        owner_cap,
    };
    transfer::public_share_object(kiosk_management);
}
```

在上述示例中，我们调用了 `kiosk::new` 来创建 kiosk。由于它返回了两个都不可删除的对象，我们需要将它们共享或转移。如果开发者选择转移并保留这些对象，那么这些 kiosks 可以被视为“个人 kiosks”，因为所有列表和购买都需要对 kiosk 和/或所有者权限的可变访问，而这些只有所有者拥有。

在上述示例中，我们将 kiosk 对象设为共享，并将所有者权限添加到共享的 `KioskManagement` 对象中。这将使 kiosk 无需权限——任何人都可以在其上进行列表，前提是遵守我们在列表函数中设定的任何规则：

```move
public fun list_on_kiosk<T: key + store>(
    kiosk: &mut Kiosk,
    kiosk_management: &KioskManagement,
    nft: T,
) {
    // 想对列出的NFT进行的任何验证
    kiosk::place(kiosk, &kiosk_management.owner_cap, nft);
    // 跟踪列出者
}
```

`kiosk::place` 需要一个对 `KioskOwnerCap` 对象的引用，可以从共享的 `kiosk_management` 对象中获取。用户必须调用我们的 `list_on_kiosk` 函数，而不能直接调用 `kiosk::place`，因为他们无法直接访问 `KioskManagement` 中的所有者权限对象。这里还有一个注意事项是，NFT要被列出售，其类型必须具有 `store` 能力。

卖家也可以下架NFT。需要确保调用 `delist` 的人是最初创建该列表的人。这可以通过具有动态字段的共享对象来跟踪。

```move
public fun delist<T: key + store>(
    kiosk: &mut Kiosk,
    kiosk_management: &KioskManagement,
    nft_id: ID,
) {
    let sender = tx_context::sender(ctx);
    // 验证发送者是否与创建列表的人相同。
    let nft = kiosk::take<T>(kiosk, &kiosk_management.owner_cap, nft_id);
    transfer::public_transfer(nft, sender);
}
```
由于 kiosk 是一个共享对象，任何人都可以直接调用 `sui::kiosk::purchase` 从列表中购买一个 NFT:

```move
/// 进行交易：支付物品的所有者并请求转移到 `target` kiosk（以防止物品被批准方拿走）。
/// 收到的 `TransferRequest` 需要由 T 的发布者处理，如果他们有允许交易的方法实现，可以请求他们的批准（通过调用某个函数），以便最终完成交易。

public fun purchase<T: key + store>(
    self: &mut Kiosk, id: ID, payment: Coin<SUI>
): (T, TransferRequest<T>) {
    let price = df::remove<Listing, u64>(&mut self.id, Listing { id, is_exclusive: false });
    let inner = dof::remove<Item, T>(&mut self.id, Item { id });

    self.item_count = self.item_count - 1;
    assert!(price == coin::value(&payment), EIncorrectAmount);
    df::remove_if_exists<Lock, bool>(&mut self.id, Lock { id });
    coin::put(&mut self.profits, payment);

    event::emit(ItemPurchased<T> { kiosk: object::id(self), id, price });

    (inner, transfer_policy::new_request(id, price, object::id(self)))
}
```
请注意，尽管这会返回购买的 NFT，但它也会返回一个不能丢弃的 TransferRequest，该请求需要在交易结束前“验证”。我们将在下一课中讨论有关 TransferPolicy 的更多内容。