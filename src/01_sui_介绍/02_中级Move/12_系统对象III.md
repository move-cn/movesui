## 系统对象 - 时钟

我们将要研究的最后一个系统对象是时钟对象。它允许用户获取 Sui 区块链上记录的当前时间：

```move
use sui::clock;

public entry fun get_time(clock: &Clock) {
    let timestamp_ms = clock::timestamp_ms(clock);
}
```
请注意，返回的时间戳是以毫秒为单位的（1 秒 = 1000 毫秒）。
时间戳有两种常见的使用方式：

1. 获取时间戳以进行记录或触发事件。

```move
struct TimeEvent has copy, drop {
    timestamp_ms: u64,
}
    
public entry fun get_time(clock: &Clock) {
    event::emit(TimeEvent { timestamp_ms: clock::timestamp_ms(clock) });
}
```
2. 生成一个伪随机数。这在技术上容易受到验证者操纵，因为验证者可以在非常小的误差范围内设置时间戳。

```move
entry fun flip_coin(clock: &Clock): u64 {
    let timestamp_ms = clock::timestamp_ms(clock);
    // 0 is heads, 1 is tails
    timestamp % 2
}
```