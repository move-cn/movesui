/*
在上一课中，我们定义了 AdminCap 结构体，但它还不是一个有效的对象类型。让我们来：

	1.	更新 AdminCap：赋予它 key 能力，并添加一个类型为 UID 的 id 字段。
	2.	添加一个新的私有函数 init：这个函数接受一个类型为 &mut TxContext 的参数 ctx，并创建一个 AdminCap 对象，其 num_frens 字段设置为 1000。init 函数在模块部署到区块链时会自动调用。
	3.	共享 AdminCap 对象：使任何人都可以使用它来创建 Frens。我们稍后会介绍如何使特定账户拥有 AdminCap 并创建 Frens。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};

    struct AdminCap {
        num_frens: u64,
    }
}