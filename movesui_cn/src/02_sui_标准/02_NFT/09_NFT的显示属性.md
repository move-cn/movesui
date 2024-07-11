## NFT 的显示属性

在之前的课程中，我们已经了解了如何在铸造 NFT 时添加属性：

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

在中级对象课程中，我们讨论了 Display 对象及其如何用来指导 Web UI 和钱包向用户显示对象。它还可以允许添加仅用于显示目的的属性，而不会增加实际对象的负担，并且可以用于应用于所有相同类型对象的跨领域更改。
我们还可以使用 Display 对象来决定 NFT 对象的显示方式，通过在集合铸造时创建一个 Display 对象来实现：

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
    
    let publisher = package::claim(otw, ctx);
    let display_object = display::new<KiteNFT>(&publisher, ctx);
    display::add_multiple(
        &mut display,
        vector[
            utf8(b"All attributes"),
            utf8(b"url"),
        ],
        vector[
            utf8(b"All attributes: {attributes}"),
            utf8(b"Image url: {url}"),
        ],
    );
    display::update_version(&mut display);
    transfer::public_transfer(display, tx_context::sender(ctx));
}
```
一旦 Display 对象被创建，就会触发一个事件，使 Sui 网络节点能够检测到 Display 对象。随后，每当通过节点 API 获取对象时，其显示属性也会按照指定的格式进行计算，并与对象的其他字段一起返回。

在上面的例子中，我们还将 Display 对象发送给模块部署者，以便在未来需要更新显示属性和格式时进行修改。如果开发者确定显示属性不会改变，他们也可以冻结该对象。如果他们希望自定义逻辑来决定何时可以添加/修改/删除显示属性，他们也可以共享该对象。