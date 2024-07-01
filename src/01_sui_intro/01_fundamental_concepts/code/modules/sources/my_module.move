module modules::my_module {
    use sui::object::UID;

    // All structs that are the core of an object need to have the `key` attribute and an id field of type UID.
    public struct MyObject has key {
        id: UID,
        color: u64,
    }

}
