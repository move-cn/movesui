## 更多 Balance 函数

定义 Balance 对象的 sui::balance 模块还提供了一些值得注意的函数：

1. `value` 返回 Balance 对象中的代币数量：

```move
/// 获取储存在`Balance`里的值.
public fun value<T>(self: &Balance<T>): u64 {
    self.value
}
```
2. `join` 接受一个可变的 Balance 和另一个 Balance，并将第二个 Balance 添加到第一个 Balance 中：

```move
/// 结合两个Balance.
public fun join<T>(self: &mut Balance<T>, balance: Balance<T>): u64 {
    let Balance { value } = balance;
    self.value = self.value + value;
    self.value
}
```
3. `split` 从一个可变的 Balance 中提取一定数量的代币，并创建第二个 Balance：

```move
/// 拆分一个 `Balance` 并从中获取一个子余额。
public fun split<T>(self: &mut Balance<T>, value: u64): Balance<T> {
    assert!(self.value >= value, ENotEnough);
    self.value = self.value - value;
    Balance { value }
}
```
4. `withdraw_all` 类似于 `split`，但会提取所有可变余额中的代币，将其清空：

```move
/// 提取所有余额. 之后余额将为0.
public fun withdraw_all<T>(self: &mut Balance<T>): Balance<T> {
    let value = self.value;
    split(self, value)
}
```
通过这些不同的函数，开发人员可以在从用户拥有的 Coin 对象中取出余额后，进行更复杂的操作。余额可以拆分和合并，将一定数量的代币分成更小的部分并发送到不同的钱包中。这在处理费用时非常常见，例如：

```move
/// 提取所有余额. 之后余额将为0.
public fun trade(wallet: &mut Coin<Sui>, amount: u64) {
    let coins_to_trade = balance::split(coin::balance_mut(wallet), amount);
    // 1% 手续费.
    let fees = balance::split(&mut coins_to_trade, amount / 100);
    // 将手续费存到某个地方然后继续交易
}
```