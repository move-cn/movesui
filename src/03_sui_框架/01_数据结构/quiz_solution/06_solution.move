public fun sort<T: copy>(v: vector<T>): vector<T> {
    let pq = priority_queue::new(vector[]);
    let i = 0;
    while (i < vector::length(&v)) {
        priority_queue::insert(&mut pq, vector::borrow(&v, i), vector::borrow(&v, i));
        i = i + 1;
    };
    let res = vector[];
    while (vector::length(&pq.entries) > 0) {
        let (_, value) = priority_queue::pop_max(&mut pq);
        vector::push_back(&mut res, value);
    };
    res
}