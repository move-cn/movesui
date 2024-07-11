public fun get_rand_number(ctx: &mut TxContext): u64 {
    let id = fresh_object_address(ctx);
    let epoch = epoch(ctx);
    let timestamp = epoch_timestamp_ms(ctx);
    let rand = (id + epoch + timestamp) % 100;
    rand
}