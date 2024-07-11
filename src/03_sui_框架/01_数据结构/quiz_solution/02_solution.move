module exercise::whitelist {
    use sui::table::{Self, Table};
    use sui::tx_context::TxContext;

    public fun new(ctx: &mut TxContext) -> Table<u64, bool> {
        table::new(ctx)
    }

    public fun add(table: &mut Table<u64, bool>, address: u64) {
        table::add(table, address, true)
    }

    public fun remove(table: &mut Table<u64, bool>, address: u64) {
        table::remove(table, address)
    }

    public fun contains(table: &Table<u64, bool>, address: u64) -> bool {
        table::contains(table, address)
    }
}