/*
练习：添加函数以创建、添加和从白名单中移除地址。
*/

module exercise::whitelist {
    use sui::table::{Self, Table};
    use sui::tx_context::TxContext;

    // 创建新白名单
    public fun new(ctx: &mut TxContext) -> Table<u64, bool> {
    }

    // 添加地址到白名单
    public fun add(table: &mut Table<u64, bool>, address: u64) {
    }

    // 从白名单移除地址
    public fun remove(table: &mut Table<u64, bool>, address: u64) {
    }

    // 检查地址是否在白名单内
    public fun contains(table: &Table<u64, bool>, address: u64) -> bool {
    }
}