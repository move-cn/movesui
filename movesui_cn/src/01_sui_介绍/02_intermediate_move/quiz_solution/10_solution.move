module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;
    use sui::package;
    use sui::types;

    friend 0x123::fren_summer;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct SUI_FREN has drop {}

    fun init(witness: SUI_FREN, ctx: &mut TxContext) {
        assert!(types::is_one_time_witness(&witness), ENotOneTimeWitness);
        let publisher_object = package::claim(witness, ctx);
        transfer::public_transfer(publisher_object, tx_context::sender(ctx));
    }
}