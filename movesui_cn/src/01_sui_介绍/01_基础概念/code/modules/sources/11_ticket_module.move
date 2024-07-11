module modules::ticket_module_11 {
  use sui::clock::{Self, Clock};
  use sui::object::{Self, UID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};
 
  public struct Ticket has key {
      id: UID,
      expiration_time: u64,
  }
 
  public fun create_ticket(ctx: &mut TxContext, clock: &Clock) {
        let ticket = Ticket {
             id: object::new(ctx),
             expiration_time: clock::timestamp_ms(clock),
        };
        // tx_context::sender(ctx) returns the address of the user who sends this transaction.
        transfer::transfer(ticket, tx_context::sender(ctx));
  }
 
  public fun is_expired(ticket: &Ticket, clock: &Clock): bool {
     ticket.expiration_time >= clock::timestamp_ms(clock)
  }
}
