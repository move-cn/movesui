public fun remove_duplicates(v: &mut vector<u64>) {
    let i = 0;
    while (i < vector::length(v)) {
        if (borrow(v, i) == borrow(v, i + 1)) {
            remove(v, i);
        } else {
            i = i + 1;
        }
    }
}