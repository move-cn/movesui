## NFT属性

如上一课所示，向代币添加属性的最佳方式是在它刚被铸造时。`mint_nft` 函数可以从用户那里获取属性列表，或者根据需要添加自己的属性：

```move
use nft_protocol::attributes::{Self, Attributes};
use nft_protocol::mint_cap;
use nft_protocol::mint_event;
use sui::url;

struct KiteNFT has key {
    id: UID,
    url: Url,
    attributes: Attributes,
}

public fun mint_nft(
    mint_cap: &MintCap<Kite>,
    name: String,
    description: String,
    url: String,
    ctx: &mut TxContext,
) {
    let attributes = attributes::from_vec(
        vector[string::utf8(b"name"), string::utf8(b"description")],
        vector[name, description],
    );
    let nft = KiteNFT {
        id: object::new(ctx),
        url: url::new_unsafe(url),
        attributes,
    };
    transfer::public_transfer(nft, tx_context::sender(ctx));
    
    mint_event::emit_mint(
        witness::from_witness(Witness {}),
        mint_cap::collection_id(mint_cap),
        &nft,
    );
}
```
开发者在决定如何向 NFT 添加属性时，有一个有趣的权衡：

1. 直接作为 NFT 结构体中的字段（例如名称、描述）
2. 通过 attributes 添加

使用 attributes 的主要好处是，因为可以在以后（铸造后）添加新属性，而不必向 NFT 结构体添加新字段。模块部署后，现有的结构体不能被修改或添加新字段。

```move
use sui::vec_map;

public fun add_new_attributes(kite_nft: &mut KiteNFT, new_attribute_name: String, new_attribute_value: String) {
    let new_attributes = vec_map::empty<String, String>();
    vec_map::insert(&mut new_attributes, new_attribute_name, new_attribute_value);
    attributes::add_new(&mut kite_nft.id, new_attributes);
}
```
`attributes::add_new` 需要一个 VecMap（键到值的映射），所以在调用该函数之前我们需要创建一个。键和值的类型可以是任何类型（原语、结构体等），只要键的类型是可复制的。