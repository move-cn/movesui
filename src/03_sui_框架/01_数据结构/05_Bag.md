## Bag - 异构数据袋

与只能存储相同类型元素的向量和基于表的数据结构不同，Bag 可以存储不同类型的元素。这是因为 Bag 是一组键值对的集合，其中键是唯一标识符，值是与键关联的数据。键可以是任何类型，值也可以是任何类型。这使得 Bag 成为一种非常灵活的数据结构，但也比向量或表更复杂一些。表类数据结构和 Bag 在底层都使用了动态字段。Bag 特别适用于开发人员希望接受不同类型的支付代币或杂项对象的情况。请注意，由于 Bag 也使用动态字段，因此它最多只能存储 1000 个项目（动态字段的限制）。

创建 Bag：
```move
let bag = bag::new();
```
将键值对添加到 Bag 中：
```move
bag::add(&mut bag, b"name", b"John Doe");
bag::add(&mut bag, b"age", 25);
```
具有相同键的键值对不能存在于同一个 Bag 中。只有具有复制（copy）、丢弃（drop）和存储（store）能力的键才能添加到 Bag 中。只有具有存储（store）能力的值才能添加到 Bag 中。

从 Bag 中检索值:
```move
let name = bag::borrow(&bag, b"name");
let age = bag::borrow(&bag, b"age");
```
修改 Bag 中的值：
```move
let age = bag::borrow_mut(&mut bag, b"age");
*age = 26;
```
有两种方法可以检查 Bag 中是否存在某个元素：
1. 检查特定键是否存在于 Bag 中：
```move
if (bag::contains(&bag, b"name")) {
    // 做点什么
}
```
检查键是否存在以及该值是否为特定类型：
```move
if (bag::contains_with_type::<vector<u8>, u64>(&bag, b"age")) {
    // 做点什么
}
```
从 Bag 中移除值
```move
let age = bag::remove(&mut bag, b"age");
```
Bag 不能自动销毁。它必须在为空的情况下才能被销毁：
```move
bag::destroy_empty(bag);
```

