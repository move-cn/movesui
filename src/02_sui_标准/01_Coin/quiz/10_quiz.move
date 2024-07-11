/*
让我们把这些概念整合到一个简单的 SuiFren 糖果空投模块中：

1. 创建一个新的模块 candy_drop，定义 Candy 代币（我们将其保存在这里，而不是在 sui_fren 中）。
2. 实现一个 init 函数来创建代币并存储 TreasuryCap。元数据应该被冻结，因为我们不会在以后更改任何内容。
3. 添加一个 mint 入口函数，允许用户在添加到允许列表中的情况下自由铸造一定数量（u64）的糖果。
   你不需要实现允许列表，只需假设有一个名为 is_allowlisted 的现有函数，该函数接受一个地址，如果地址在允许列表中则返回 true。
   我们将在后续课程中介绍如何实现这一点。你可以使用 assert!(condition, ENOT_NOT_ALLOWLISTED)。
*/

module 0x123::candy_drop {
    // 在这里实现

    fun is_allowlisted(user: address): bool {
        // 不需要实现这个
    } 
}