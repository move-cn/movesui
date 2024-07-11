/*
添加一个新的公共函数 add_display，该函数为 SuiFren 创建一个显示对象，并使用以下格式化规则：

- id 将被格式化为 id: {id}
- generation 将被格式化为 generation: {generation}
- birthdate 将被格式化为 birthdate: {birthdate}
- all attributes 将被格式化为 all attributes: {attributes} 显示对象应发送给发送者。
*/

module 0x123::sui_fren {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;
    use std::string::String;
    use std::vector;
    use sui::event;

    friend 0x123::fren_summer;
    
    struct SuiFren has key, store {
        id: UID,
        generation: u64,
        birthdate: u64,
        attributes: vector<String>,
    }

    struct SUI_FREN has drop {}

    fun init(witness: SUI_FREN, ctx: &mut TxContext) {
        assert!(types::is_one_time_witness(&witness), ENotOneTimeWitness);
        let publisher_object = package::claim(witness, ctx);
        transfer::public_transfer(publisher_object, tx_context::sender(ctx));
    }

    // 这里添加新函数
}