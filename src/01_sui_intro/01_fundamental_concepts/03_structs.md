Data on the Sui blockchain can be organized into structs. Structs can be thought of as a group of related fields, each with its own type such as numbers, booleans, and vectors. Struct is a foundational concept in Sui Move.

````move
{{#include ./code/modules/sources/my_module.move}}
````

- In the example above, we're defining a simple struct MyObject with two fields id and color. Each struct can be defined as having "abilities" - key, store, drop, copy. We'll explain more later what these abilities mean.

## Move types
- Move supports multiple different types:

- Unsigned integers: u8, u16, u32, u64, u128, u256 The different types of integers have different maximum values they can store. For example, u8 can store values up to 2^8 - 1 or 255, while u256 can store values up to 2^256 - 1.
## Booleans: bool
Addresses: address. Address is a core construct in blockchains and represents a user identity. Users can generate addresses from keys that only they have off-chain and use them to sign transactions. This proves that the transactions do come from the users and are not fake.
String
Vector. An array of u64 would be vector<u64>.
Custom struct types such as UID imported with use sui::object::UID in the earlier example.