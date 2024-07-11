public fun deserialize(bytes: vector<u8>): Info {
    use sui::bcs::{Self, BCS};

    let prepared: BCS = bcs::new(bytes);
    let (a, b, c, d, k, s) = (
        bcs::peel_bool(&mut prepared),
        bcs::peel_u8(&mut prepared),
        bcs::peel_u64(&mut prepared),
        bcs::peel_u128(&mut prepared),
        bcs::peel_vec_bool(&mut prepared),
        bcs::peel_address(&mut prepared)
    );

    Info { a, b, c, d, k, s }
}