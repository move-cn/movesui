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
        let hat = Hat {
            id: object::new(ctx),
            color,
        };
        transfer::transfer(hat, object::uid_to_address(&sui_fren.id));
    }

    public fun update_hat_color(sui_fren: &mut SuiFren, hat: Receiving<Hat>, color: String, ctx: &mut TxContext) {
        let hat = transfer::receive(&mut sui_fren.id, hat);
        hat.color = color;
        transfer::transfer(hat, object::uid_to_address(&sui_fren.id));
    }
}