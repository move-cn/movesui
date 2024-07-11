module 0x123::sui_fren {
    use sui::object::{Self, UID, ID};
    use sui::tx_context::TxContext;
    use std::string::String;
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use nft_protocol::mint_cap;
    use nft_protocol::mint_event;
    use sui::event;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
    }

    struct SUIFREN has drop {}
    
    struct Witness has drop {}

    struct DeleteFrenEvent has copy, drop {
        fren_id: ID,
    }

    fun init(otw: SUIFREN, ctx: &mut TxContext) {
        let (collection, mint_cap) =
            collection::create_with_mint_cap<SUIFREN, SuiFren>(&otw, option::none(), ctx);
        let delegated_witness = witness::from_witness(Witness {});
        
        collection::add_domain(
            delegated_witness,
            &mut collection,
            display_info::new(
                string::utf8(b"SuiFrens"),
                string::utf8(b"A collection of SuiFrens who hangout together"),
            ),
        );
        transfer::public_share_object(collection);
        transfer::public_share_object(mint_cap);

        let publisher = package::claim(otw, ctx);
        let display_object = display::new<SuiFren>(&publisher, ctx);
        display::add_multiple(
            &mut display,
            vector[
                utf8(b"generation"),
                utf8(b"birthdate"),
            ],
            vector[
                utf8(b"SuiFren generation: {generation}"),
                utf8(b"Born on {birthdate}"),
            ],
        );
        display::update_version(&mut display);
        transfer::public_transfer(display, tx_context::sender(ctx));
    }

    entry fun delete_fren(sui_fren: SuiFren) {
        let SuiFren {id, generation: _, birthdate: _, attributes: _ } = sui_fren;
        let fren_id = object::uid_to_inner(&id);
        object::delete(id);
        event::emit(DeleteFrenEvent { fren_id });
    }
}
