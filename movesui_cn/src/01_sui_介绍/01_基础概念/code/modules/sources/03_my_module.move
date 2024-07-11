module modules::my_module_03 {
    use sui::object::UID;

    // 所有作为对象核心的结构体都需要具有 `key` 属性，并且需要一个类型为 UID 的 id 字段。
    public struct MyObject has key {
        id: UID,
        color: u64,
    }

}
