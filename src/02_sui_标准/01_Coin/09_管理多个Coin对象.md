## 管理多个 Coin 对象 - join和split

想象一下，每次你与应用程序互动时，它都会创建一个新的 Coin 对象来存储退款或付款到你的账户。在一天的互动之后，你最终会有100个不同的 Coin 对象。现在你的代币被分成100个不同的部分，你不再有足够的代币进行更多的互动了。你现在该怎么办？

有两个解决方案：
1. 应用程序和开发人员尽可能避免创建新的代币，除非必须这样做。他们应该尝试从用户那里取出一个现有的 Coin，将退款/付款合并到其中。
2. 用户可以将代币合并在一起，作为他们 PTB（可编程交易块）的最后一步。

在 Move 中，代币也可以很容易地使用 `coin::split` 和 `coin::join` 进行拆分和合并。

```move
public fun trade(input_coins: &mut Coin<SUI>) {
    let refund_coins - ...;
    coin::join(input_coins, refund_coins);
}
```
代币也可以被拆分。然而，请记住，创建的代币要么必须合并到其他代币中，要么需要发送到一个账户。这是因为 Coin 没有 drop 能力，不能在函数结束时被丢弃。

```move
public fun split_and_send(input_coins: &mut Coin<SUI>, ctx: &TxContext) {
    let refund_coins = coin::split(input_coins, 1000);
    transfer::public_transfer(refund_coins, tx_context::sender(ctx));
}
```
你可能还注意到，这与我们在前面课程中学习到的 `balance::split` 和 `balance::join` 很相似。除了这些函数处理的类型不同——Coin 和 Balance 之外，它们在 Move 中的行为几乎是相同的。然而，coin 的函数更多地用于 PTB（可编程交易块），因为应用程序通常返回 Coin 而不是 Balance，而 `balance::split` 和 `balance::join` 更多地用作 Move 流程的一部分。