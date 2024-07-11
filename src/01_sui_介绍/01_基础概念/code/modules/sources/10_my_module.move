module modules::my_module_10 {
   use std::vector;
   use sui::object::{Self, UID};
   use sui::transfer;
   use sui::tx_context::TxContext;


   public struct MyObject has key {
       id: UID,
       value: u64,
   }


   fun init(ctx: &mut TxContext) {
       let my_object = MyObject {
           id: object::new(ctx),
           value: 10,
       };
       transfer::share_object(my_object);
   }


   public fun set_value(my_object: &mut MyObject, value: u64) {
       my_object.value = value;
   }
}
