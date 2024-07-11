module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use std::string::String;
    use sui::dynamic_object_field;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct Hat has key, store {
        id: UID,
        color: String,
    }

    public fun color_hat(sui_fren: &mut SuiFren, color: String, ctx: &mut TxContext) {
        if (dynamic_object_field::exists_(&sui_fren.id, string::utf8(HAT_KEY))) {
            let hat: &mut Hat = dynamic_object_field::borrow_mut(&mut sui_fren.id, string::utf8(HAT_KEY));
            hat.color = color;
        } else {
            let hat = Hat {
                id: object::new(ctx),
                color,
            };
            dynamic_object_field::add(&mut sui_fren.id, string::utf8(HAT_KEY), hat);
        }
    }
}