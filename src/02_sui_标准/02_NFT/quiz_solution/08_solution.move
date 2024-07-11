module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use std::string::String;
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use nft_protocol::mint_cap;
    use nft_protocol::mint_event;
    use nft_protocol::display_info;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: Attributes,
    }

    struct SUIFREN has drop {}
    
    struct Witness has drop {}

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

        let shares = vector[100];
        let creator = tx_context::sender(ctx);
        let shares = utils::from_vec_to_map(creator, shares);
        royalty_strategy_bps::create_domain_and_add_strategy(
            delegated_witness, &mut collection, royalty::from_shares(shares, ctx), 200, ctx,
        );    

        let publisher = package::claim(otw, ctx);
        let (transfer_policy, transfer_policy_cap) =
            transfer_request::init_policy<SuiFren>(&publisher, ctx);
        royalty_strategy_bps::enforce(&mut transfer_policy, &transfer_policy_cap);

        transfer::public_transfer(collection, tx_context::sender(ctx));
        transfer::public_share_object(mint_cap);
    }

    public fun update_collection_description(collection: &mut Collection<SuiFren>, new_description: String) {
        display_info::change_description(collection::borrow_uid_mut(Witness {}, collection), new_description);
    }
}
