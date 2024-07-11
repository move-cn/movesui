module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    public fun get_attributes(sui_fren: &SuiFren): vector<String> {
        sui_fren.attributes
    }

    public fun update_attributes(sui_fren: &mut SuiFren, attributes: vector<String>) {
        sui_fren.attributes = attributes;
    }
}
