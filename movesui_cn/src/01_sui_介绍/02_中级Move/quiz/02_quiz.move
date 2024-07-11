/*
更新 fren_summer::open_box 为私有入口函数。
*/

module 0x123::fren_summer {
    use 0x123::sui_fren;

    public fun open_box(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        sui_fren::mint(generation, birthdate, attributes, ctx);
    }
}