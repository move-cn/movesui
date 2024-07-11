## 添加、更新和删除 Collection 的属性

在前一课中，我们了解了如何使用预定义属性列表创建 NFT 集合：

```move
use nft_protocol::display_info;
use ob_permissions::witness;
use std::string::{Self, String};

/// 可用于创建后授权其他操作。至关重要的是，这个结构体不能随意提供给任何合约，因为它充当授权令牌。
struct Witness has drop {}

fun init(otw: KITE, ctx: &mut TxContext) {
    let (collection, mint_cap) =
        collection::create_with_mint_cap<KITE, KiteNFT>(&otw, option::none(), ctx);
    let delegated_witness = witness::from_witness(Witness {});
    
    collection::add_domain(
        delegated_witness,
        &mut collection,
        display_info::new(
            string::utf8(b"Kites"),
            string::utf8(b"A NFT collection of Kites on Sui"),
        ),
    );
}
```
这些属性在集合创建之后也可以进行修改。在权限方面，开发者有两个选择：

1. 允许任何人修改集合的属性，但须遵守特定规则（例如由协议定义的特定账户）。在这种情况下，Collection 对象需要是共享对象。
2. 将 Collection 对象保持为拥有对象，并将其转移到有权限修改集合属性的账户。

无论哪种方式，这都可以在调用添加/更新/删除集合属性的函数时，指定集合对象的可变引用。要在以后添加一组属性（域），我们只需要委托见证对象并再次调用 `collection::add_domain`。

```move
public fun add_collection_attributes_group(collection: &mut Collection<KiteNFT>, attributes: vector<String>) {
    collection::add_domain(
        delegated_witness,
        &mut collection,
        attributes,
    );
}
```
由于域可以是任何类型，它可以是单个属性或一组属性——您可以添加向量、VectorMap 或任何其他包含多个属性的容器。请注意，每种类型的域只能添加一次，因为它们在幕后是通过动态字段添加的。
要修改现有的域（可以是单个属性或包含属性的容器）：

```move
public fun update_collection_string_attribute(collection: &mut Collection<KiteNFT>, new_value: String) {
    let string_attribute = collection::borrow_domain_mut<KiteNFT, String>(
        delegated_witness,
        &mut collection,
    );
    *string_attribute = new_value;
}
```
要修改使用 DisplayInfo 为集合设置的名称或描述：

```move
public fun update_collection_name_and_desc(collection: &mut Collection<KiteNFT>, new_name: String, new_desc: String) {
    display_info::change_name(collection::borrow_uid_mut(Witness {}, collection), new_name);
    display_info::change_description(collection::borrow_uid_mut(Witness {}, collection), new_desc);
}
```
要删除一个域，包括可删除的 DisplayInfo，请执行以下操作：

```move
public fun delete_collection_display_info(collection: &mut Collection<KiteNFT>) {
    collection::remove_domain<KiteNFT, DisplayInfo>(Witness {}, collection);
}
```