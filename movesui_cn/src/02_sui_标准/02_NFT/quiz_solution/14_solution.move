module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use std::option::{Self, Option};
    use std::string::String;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        hat: Option<Hat>,
        sunglasses: Option<SunGlasses>,
    }

    struct Hat has key {
        id: UID,
        diameter: u64
    }

    struct SunGlasses has key {
        id: UID,
        color: String,
    }

    entry fun wear_hat(sui_fren: &mut SuiFren, hat: Hat) {
        option::fill(&mut sui_fren.hat, hat);
    }

    entry fun wear_sunglasses(sui_fren: &mut SuiFren, sun_glasses: SunGlasses) {
        option::fill(&mut sui_fren.sun_glasses, sun_glasses);
    }
}
