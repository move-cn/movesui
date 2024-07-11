/*
更新 sui_fren 模块，使用 OriginByte 标准为 SuiFrens 创建一个 NFT 集合。确保不要遗漏任何导入。还要记住，一次性见证对象类型必须以特定方式命名（如果忘记了，请查看第一课）。SuiFren 集合应具有以下显示属性：

1. 名称："SuiFrens"
2. 描述："A collection of SuiFrens who hangout together"

目前我们不会共享 MintCap 对象。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use std::string::String;
    use nft_protocol::attributes::Attributes;
    // 这里添加新引进
    
    struct SuiFren has key {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: Attributes,
    }

    // 这里添加新结构体

    // 更新
    fun init() {

    }
}
