module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }
}

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    
    struct AdminCap has key {
        id: UID,
        num_frens: u64,
    }
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    public fun mint(generation: u64, birthdate: u64, attributes: vector<String>, ctx: &mut TxContext): SuiFren {
        SuiFren {
            id: object::new(ctx),
            generation,
            birthdate,
            attributes,
        }
    }
}
