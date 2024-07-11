module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;

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

    public fun create_display_object(publisher: &Publisher, ctx: &mut TxContext) {
        let display_object = display::new<SuiFren>(&publisher, ctx);
        display::add_multiple(
            &mut display_object,
            vector[
                utf8(b"id"),
                utf8(b"generation"),
                utf8(b"birthdate"),
                utf8(b"attributes"),
            ],
            vector[
                utf8(b"id: {id}"),
                utf8(b"generation: {generation}"),
                utf8(b"birthdate: {birthdate}"),
                utf8(b"all attributes: {attributes}"),
            ],
        );
        display::update_version(&mut display_object);
        transfer::public_transfer(display_object, tx_context::sender(ctx));
    }
}