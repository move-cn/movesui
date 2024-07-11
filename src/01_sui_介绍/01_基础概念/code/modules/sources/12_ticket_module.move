module modules::ticket_module_12 {
  use sui::clock::{Self, Clock};
  use sui::object::{Self, UID};
  use sui::transfer;
  use sui::tx_context::TxContext;
 
  public struct Ticket has key {
      id: UID,
      expiration_time: u64,
  }
 
  public fun clip_ticket(ticket: Ticket) {
     let Ticket {
         id,
         expiration_time: _,
     } = ticket;
     object::delete(id);
  }
}
