module sui::sui_fren {
    use std::string::String;
    use sui::object::UID;
    use sui::url::Url;

    struct SuiFrenCollection has key {
        id: UID,
        creator: address,
        name: String,
        description: String,
        limit: u64,
        url: Url,
    }

    struct SuiFren has key {
        id: UID,
        collection: address,
        name: String,
        url: Url,
        attributes: vector<String>,
    }
}