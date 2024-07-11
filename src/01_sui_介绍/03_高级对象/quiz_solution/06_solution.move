module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use std::string::String;
    use sui::dynamic_field;
    use sui::dynamic_object_field;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    const HAT_KEY: vector<u8> = b"HAT";

    struct Hat has key, store {
        id: UID,
        color: String,
    }

    const EXTENSION_1: u64 = 1;

    struct HatExtension1 has store {
        description: String,
        duration: u64,
    }

    public fun extend_hat(sui_fren: &mut SuiFren, description: String, duration: u64) {
        if (dynamic_object_field::exists_(&sui_fren.id, string::utf8(HAT_KEY))) {
            let hat: &mut Hat = dynamic_object_field::borrow_mut(sui_fren, string::utf8(HAT_KEY));
            dynamic_field::add(&mut hat.id, EXTENSION_1, HatExtension1 {
                description,
                duration,
            });
        };
    }
}