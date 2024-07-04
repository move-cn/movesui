module modules::ticket_module_05 {
    use sui::clock::{Self, Clock};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    public struct Ticket has key {
        id: UID,
        expiration_time: u64,
    }

  public fun is_expired(ticket: &Ticket, clock: &Clock): bool {
     ticket.expiration_time >= clock::timestamp_ms(clock)
  }
}
