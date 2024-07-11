public fun remove_duplicates<K: copy + drop + store, V: store>(table: &mut LinkedTable<K, V>) {
    let mut current = *option::borrow(&table.head);
    while (option::is_some(&linked_table::next(table, current))) {
        let next = *option::borrow(&linked_table::next(table, current));
        if (linked_table::borrow(table, current) == linked_table::borrow(table, next)) {
            linked_table::remove(table, next);
        } else {
            current = next;
        }
    }
}