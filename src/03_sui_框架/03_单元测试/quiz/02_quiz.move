/*
练习：给定以下模块：
编写一个测试模块，包含一个测试，通过一个断言验证 add 函数是否正确处理 1 + 2 等于 3。
*/

module my_package::math {
    public fun add(x: u64, y: u64): u64 {
        x + y
    }
}