## 销毁NFTs

类似于普通对象，NFT 也可以被销毁。这是游戏中的常见功能，可用于：

1. 实现物品制作。用户可以烧毁一些材料物品来制作武器或调制药水。
2. 表示物品损失。当护甲破损时，它会被销毁并从用户的库存中消失。

应用程序还可以销毁消耗性NFT，例如音乐会门票或抽奖券。

```move
use nft_protocol::mint_event;

struct Witness has drop {}

struct Ticket has key {
    id: UID,
    expiration: u64,
}

public fun clip_ticket(
    collection: &mut Collection<Ticket>,
    ticket: Ticket,
) {
    let Ticket {id, expiration: _ } = ticket;
    object::delete(id);
    
    // 更新集合的供应量
}
```
这将销毁 NFT——它将在交易执行后从对象存储中移除。请注意，如果集合跟踪门票的供应量（当前有多少门票可用），则需要更新供应属性。有关更多详细信息，请参阅前面的课程“更新集合的属性”。