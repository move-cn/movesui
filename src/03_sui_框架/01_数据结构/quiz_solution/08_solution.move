public fun remove_duplicates(v: vector<u64>): vector<u64> {
    let set = vec_set::empty();
    let i = 0;
    while (i < vector::length(&v)) {
        let x = vector::get(&v, i);
        if (!vec_set::contains(&set, &x)) {
            vec_set::insert(&mut set, x);
        }
        i = i + 1;
    };
    vec_set::into_keys(set)
}