## BCS

不要与 std::bcs 中的 bcs 模块混淆，本课介绍 sui::bcs 模块，它具有更多功能。BCS 是 Sui 和 Move 的默认序列化格式。这是一种用于序列化数据以进行存储和传输的二进制格式。BCS 格式用于序列化数据以进行存储和传输。当值作为参数在交易中传递时，它们会被序列化为 BCS 格式。当交易执行时，这些值会从 BCS 格式反序列化为 Move 中的实际值。这种序列化和反序列化给 Sui 区块链带来了成本，开发者应该注意这一点。默认情况下，交易不能将非对象结构作为参数，字符串除外。

BCS 模块可以提供一种解决方法，允许开发者将类结构的值作为一系列 BCS 编码字节传递，Move 代码可以逐个提取这些值，只要它们都是原始类型、向量或选项。这允许前端序列化一个结构（这只是生成一个接一个的值序列），并且可以一次从字节中提取一个值的序列：

```move
此函数从输入中读取 u8 和 u64 值。
use sui::bcs;

public fun deserialize(bytes: vector<u8>): (u8, u64) {
    let prepared = bcs::new(bytes);
    let (u8_value, u64_value) = (
        bcs::peel_u8(&mut prepared),
        bcs::peel_u64(&mut prepared)
    );

    (u8_value, u64_value)
}
```
向量可以类似地提取（或“剥离”）：
```move
public fun deserialize(bytes: vector<u8>): vector<u8> {
    let prepared = bcs::new(bytes);
    let u8_vector = bcs::peel_vec_u8(&mut prepared);
    let u64_vector = bcs::peel_vec_u64(&mut prepared);

    u8_vector
}
```
Option:
```move
public fun deserialize(bytes: vector<u8>): Option<u8> {
    let prepared = bcs::new(bytes);
    let u8_option = bcs::peel_option_u8(&mut prepared);
    let u64_option = bcs::peel_option_u64(&mut prepared);

    u8_option
}
```