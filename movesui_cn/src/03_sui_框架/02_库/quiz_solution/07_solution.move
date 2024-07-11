public fun withdraw<CoinType>(coin: CoinType) {
    let type_name = std::type_name::get<CoinType>();
    if (type_name == string::utf8("0x123::my_module::Coin1")) {
        // Withdraw Coin1
    } else if (type_name == string::utf8("0x123::my_module::Coin2")) {
        // Withdraw Coin2
    } else if (type_name == string::utf8("0x123::my_module::Coin3")) {
        // Withdraw Coin3
    } else {
        // Unknown coin type
    }
}