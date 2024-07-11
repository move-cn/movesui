## Option

Option 类型是一种常见模式，在 Rust 和其他语言中使用。它用于表示一个可能存在或不存在的值。在 Move 中，Option 类型使用大小为零或一个元素的向量实现。

Options 有以下用途：
1. 传递给函数的可选参数
2. 结构体中的可选字段
3. 函数的可选返回值

Option 类型定义在 std::option 模块中。Option 类型是一个泛型类型，这意味着它可以包含任何类型的值。Option 类型有两个变体：Some 和 None。Some 变体包含一个值，而 None 变体则不包含任何值。

可以使用以下方式创建一个可选值：
```move
let absent = option::none();
let some_value = option::some(42);
```
Options 可以用于基本类型和结构体：
```move
struct MyStruct {
    value: u64
}
let some_struct = option::some(MyStruct{value: 42});
let value = option::borrow(&some_struct).value;
```
Option 类型有几种方法可以处理可选值：
- `is_none`：如果 Option 是 None，则返回 true
```move
let absent = option::none();
assert!(option::is_none(&absent), 0);
```
- `is_some`：如果 Option 是 Some，则返回 true
```move
let some_value = option::some(42);
assert!(option::is_some(&some_value), 0);
```
- `contains`：如果 Option 包含特定值，则返回 true
```move
let some_value = option::some(42);
assert!(option::contains(&some_value, &42), 0);
```
可以从 Option 中读取一个值。如果 Option 是 None，这将中止：
```move
let some_value = option::some(42);
let value = option::borrow(&some_value);
```
如果 Option 是 None，可以从 Option 中读取一个带有默认值的值：
```move
let absent = option::none();
let value = option::borrow_with_default(&absent, &42);
```
可以从 Option 中获取一个可变引用，并用它来修改值：
```move
let some_value = option::some(42);
let value = option::borrow_mut(&some_value);
*value = 43;
```
Option 中的值可以被新的值替换：
```move
let some_value = option::some(42);
let old_value = option::swap(&some_value, 43);
```
值也可以从 Option 中填充或提取：
```move
let absent = option::none();
option::fill(&absent, 42);
let value = option::extract(&absent);
```
Option 类型可以被销毁并提取其值：
```move
let some_value = option::some(42);
let value = option::destroy_some(some_value);
```
