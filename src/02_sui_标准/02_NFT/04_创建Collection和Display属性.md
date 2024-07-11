## 创建Collection和Display属性

使用 OriginByte 标准，开发者可以轻松创建一个集合。第一步是包含上节课提到的 OriginByte 的 `nft_protocol` 和 `permissions` 包。之后，可以使用 `collection` 模块创建一个集合：

```move
module my_nft::kite {
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use std::string::String;
    use sui::url::Url;
    
    /// 一次性见证对象只能在 init 方法中实例化。
    struct KITE has drop {}
    
    struct KiteNFT has key, store {
        id: UID,
        name: String,
        description: String,
        url: Url,
        attributes: Attributes,
    }
    
    fun init(otw: KITE, ctx: &mut TxContext) {
        let (collection, mint_cap) =
            collection::create_with_mint_cap<KITE, KiteNFT>(&otw, option::none(), ctx);
        transfer::public_share_object(collection);
        transfer::public_share_object(mint_cap);
    }
}
```
一个 Collection 只能在 init 函数中创建，因为它需要一个见证对象（在第一课中讨论过）。`collection::create_with_mint_cap` 需要两个类型参数：

1. 见证对象类型。在上述例子中，这是 KITE。
2. Collection 中的 NFT 类型。我们为此创建了 KiteNFT 类型。将会在接下来的课程中详细讨论这些字段。

`collection::create_with_mint_cap` 返回两个对象——类型为 `Collection<Kite>` 的集合对象和 `mint_cap`，后者可以用于程序化地铸造代币（稍后会讨论）。这两个对象都成为共享对象，因为它们无论如何都不能被修改，只能读取。稍后我们会讨论 `MintCap` 是否可以是一个拥有的对象。

集合创建后，可以添加如名称/描述等属性：

```move
use nft_protocol::display_info;
use ob_permissions::witness;
use std::string::{Self, String};

/// 可用于创建后授权其他操作。至关重要的是，这个结构体不能随意提供给任何合约，因为它充当了授权令牌。
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

为了设置集合的名称/描述，我们需要以下几个步骤：

1. 从 OriginByte 提供的 permissions 包中导入 `ob_permissions::witness`。
2. 在同一个包中声明一个新的结构体 `Witness {}`。
3. 使用 `witness::from_witness` 创建一个“委托见证”对象。
4. 使用包含名称和描述的正确 `DisplayInfo` 对象调用 `collection::add_domain`。可以作为单独的域添加更多属性。