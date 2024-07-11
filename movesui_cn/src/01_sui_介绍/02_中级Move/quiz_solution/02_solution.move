module 0x123::fren_summer {
    use 0x123::sui_fren;

    entry fun open_box(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext) {
        sui_fren::mint(generation, birthdate, attributes, ctx);
    }
}