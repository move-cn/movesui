/*
使用 10 的指数表示法重写 AdminCap 的默认 num_frens 值。
*/

module 0x123::sui_fren {
   use sui::object::{Self, UID};
   use sui::transfer;
   use sui::tx_context::TxContext;


   struct AdminCap has key {
       id: UID,
       num_frens: u64,
   }
  
   fun init(ctx: &mut TxContext) {
       let admin_cap = AdminCap {
           id: object::new(ctx),
           num_frens: 1000,
       };
       transfer::share_object(admin_cap);
   }
}