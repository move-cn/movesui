## 铸造Token

现在我们已经创建了一个集合。让我们来讨论铸造 NFT。OriginByte 标准只规定了集合的结构：

1. 它们的集合对象非常简洁，所有属性都需要作为显示属性添加（通过 `collection::add_domain`）：

```move
struct Collection<phantom T> has key, store {
    id: UID,
    version: u64,
}
```
2. OriginByte 还提供了集合的常见功能，如创作者、版税等。
3. 开发者需要定义自己的 NFT 结构体，就像我们在前一课中看到的那样。OriginByte 只提供管理该代币的常见功能：权限（MintCap）、属性标准、显示标准等。
4. 铸造和销毁事件将 NFT 绑定回集合。

开发者/创作者首先需要定义 NFT 对象结构体，这是创建集合所需的，正如在前一课中讨论的那样：

```move
module my_nft::kite {
    use nft_protocol::attributes::Attributes;
    use nft_protocol::collection;
    use std::string::String;
    use sui::url::Url;
    
    /// One time witness is only instantiated in the init method
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
    }
}
```

一旦他们有了一个集合，他们可以像下面这样铸造 NFT：

```move
use nft_protocol::attributes::{Self, Attributes};
use nft_protocol::mint_cap;
use nft_protocol::mint_event;
use sui::url;

public fun mint_nft(
    mint_cap: &MintCap<Kite>,
    name: String,
    description: String,
    url: String,
    ctx: &mut TxContext,
) {
    let nft = KiteNFT {
        id: object::new(ctx),
        name,
        description,
        url: url::new_unsafe(url),
        attributes: attributes::from_vec(vector[], vector[])
    };
    transfer::public_transfer(nft, tx_context::sender(ctx));
    
    mint_event::emit_mint(
        witness::from_witness(Witness {}),
        mint_cap::collection_id(mint_cap),
        &nft,
    );
}
```
您可能会意识到这与创建一个对象看起来没有什么不同！这是正确的，只有一个小区别——属性是 OriginByte 提供的标准，用于存储所有代币属性。我们将在后面的课程中对此进行更多讨论。开发者还可以在这里添加更多逻辑，例如限制每个用户只能铸造一个代币，以及他们喜欢的其他规则。

铸造函数还接收一个 MintCap 对象以发出铸造事件。这是必需的，以便链外组件能够知道 KiteNFT 属于 Kite 集合。OriginByte 提供的 `mint_event::emit_mint` 还需要在 init 函数中添加显示属性时传递的委托见证对象。在大多数情况下，MintCap 可以是一个共享对象，以允许任何用户调用 `mint_nft` 函数。

```move
fun init(otw: KITE, ctx: &mut TxContext) {
    let (collection, mint_cap) =
        collection::create_with_mint_cap<KITE, KiteNFT>(&otw, option::none(), ctx);
    transfer::public_share_object(mint_cap);
}
```

如果不是这种情况，并且开发者希望限制谁可以铸造，他们可以将 MintCap 设为一个拥有的对象，并在 init 函数中将其转移到可以铸造的账户。这使得 `mint_nft` 成为一个仅由特定账户调用的权限函数。

另一个链外组件可以识别集合中 NFT 的方法是查看它们的类型。集合对象有一个类型参数，所以在上述示例中，其类型将是 `Collection<Kite>`。