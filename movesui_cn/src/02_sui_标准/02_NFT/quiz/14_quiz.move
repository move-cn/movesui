/*
1. 添加一个新的 Hat NFT，其中有一个类型为 `u64` 的 `diameter` 字段。  
2. 添加一个新的 SunGlasses NFT，其中有一个类型为 `String` 的 `color` 字段。  
3. 更新 SuiFren NFT，使其可以选择性地佩戴帽子和太阳镜。  
4. 添加两个新的入口函数 `wear_hat` 和 `wear_sunglasses`，分别允许 SuiFren 佩戴帽子和太阳镜。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
    }

    // 这里添加新结构体和函数
}
