public fun split(s: String): vector<String> {
    let result = vector[];
    let delimiter = string::utf8(b",");
    let len = string::length(s);
    while (string::index_of(s, delimiter) < len) {
        let i = string::index_of(s, delimiter);
        let part = string::sub_string(s, 0, i);
        result.push(part);
        s = string::sub_string(s, i + 1, len);
    };
    result
}