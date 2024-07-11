module modules::ticket_module_04 {
    use sui::clock::{Self, Clock};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    public struct Ticket has key {
        id: UID,
        expiration_time: u64,
    }

    public fun create_ticket(ctx: &mut TxContext, clock: &Clock) {
        let ticket = Ticket {
            id: object::new(ctx),
            expiration_time: clock::timestamp_ms(clock),
        };
        transfer::share_object(ticket);
    }
}
