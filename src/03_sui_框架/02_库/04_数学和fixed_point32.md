## 数学和fixed_point32

### 数学 - Math

数学模块为在 Move 中处理无符号整数提供了有用的数学函数。这与 EVM 世界不同，在 EVM 中用户需要部署自己的数学库。

Math模块提供了以下函数：
- `max`: 返回 x 和 y 中较大的值
```move
let max = math::max(5, 10);
assert!(max == 10, 0);
```
- `min`: 返回 x 和 y 中较小的值
```move
let min = math::min(5, 10);
assert!(min == 5, 0);
```
- `diff`: 返回 x - y 的绝对值
```move
let diff = math::diff(5, 10);
assert!(diff == 5, 0);
```
- `pow`: 返回基数的幂值
```move
let pow = math::pow(2, 3);
assert!(pow == 8, 0);
```
- `sqrt`: 获取 x 的最接近的整数平方根
```move
let sqrt = math::sqrt(9);
assert!(sqrt == 3, 0);
```
- `sqrt_u128`: 类似于 `math::sqrt`，但用于 u128 数字
```move
let sqrt = math::sqrt_u128(9);
assert!(sqrt == 3, 0);
```
- `divide_and_round_up`: 计算 x / y，但结果向上舍入
```move
let divide_and_round_up = math::divide_and_round_up(5, 2);
assert!(divide_and_round_up == 3, 0);
```

### fixed_point32

Move 没有原生的浮点数。所有数字都是无符号整数。这使得实现如 Defi 协议中的复杂数学计算变得困难。然而，Sui Move 的标准库提供了一个基于 Move 的定点数实现，具有 32 位小数位。这是一种二进制表示形式，因此十进制值可能无法精确表示，但它提供了小数点前后超过 9 位的精度（总共 18 位）。相比之下，双精度浮点数的十进制精度不到 16 位，因此在使用浮点数将这些值转换为十进制时需要小心。然而，由于 Move 表达式相对于 Move 语言中的 Rust 原生实现增加了额外的 gas 成本。目前仅支持 32 位小数和整数部分的定点数。

要创建一个定点数：
```move
let one_half = fixed_point32::create_from_rational(1, 2);
let two = fixed_point32::create_from_raw_value(2);
```
要对定点数进行算术运算：
```move
let sum = fixed_point32::add(one_half, two);
let product = fixed_point32::multiply(one_half, two);
let quotient = fixed_point32::divide(one_half, two);
```
要将定点数转换为 u64：
```move
let value = fixed_point32::get_raw_value(one_half);
```
要检查定点数是否为零：
```move
let is_zero = fixed_point32::is_zero(one_half);
```