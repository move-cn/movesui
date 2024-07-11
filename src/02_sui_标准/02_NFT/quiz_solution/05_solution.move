module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use std::string::String;
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use nft_protocol::mint_cap;
    use nft_protocol::mint_event;
    
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
        transfer::public_share_object(collection);
        transfer::public_share_object(mint_cap);
    }

    public fun mint_nft(
        mint_cap: &MintCap<SuIFren>,
        generation: u64,
        birthdate: u64,
        ctx: &mut TxContext,
    ) {
        let nft = SuiFren {
            id: object::new(ctx),
            generation,
            birthdate,
            attributes: attributes::from_vec(vector[], vector[])
        };
        transfer::public_transfer(nft, tx_context::sender(ctx));
        
        mint_event::emit_mint(
            witness::from_witness(Witness {}),
            mint_cap::collection_id(mint_cap),
            &nft,
        );
    }
}
