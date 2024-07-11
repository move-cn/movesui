## 设置 SUI 代币和测试失败案例

### 在测试中创建 SUI 代币

一些测试在测试函数时可能还需要创建 SUI 代币。这可以通过已经在 coin 模块中定义的 `#[test_only]` 函数来完成。

```move
use sui::coin;

#[test]
public fun test() {
    let coins = coin::mint_for_testing(1000);
    // 测试内容
}
```
对于自定义代币，开发者需要在初始化这些代币的模块中定义 test_only 函数，因为铸造自定义代币需要 TreasuryCap。

### 失败案例

在测试错误情况时，开发者可能希望编写预期失败的测试（例如，被测试函数由于无效输入正确地失败）。这可以通过 `#[expected_failure]` 注释来实现。

```move
#[test]
#[expected_failure(abort_code = kiosk::royalty_rule::EInsufficientAmount)]
fun test_default_flow_0_invalid_amount_fail() {
}
```
我们可以使用 `abort_code =` 来指定我们期望测试返回的中止代码，而无需硬编码。这可能是目前在 Move 中最接近公共常量的做法。近期可能会有更新，增加对公共常量的支持。