## Kiosk 标准 - 转移策略

Kiosk 有一个非常强大的功能，允许 NFT 创建者制定其 NFT 交易的规则，例如我们在之前课程中看到的版税：转移策略 (TransferPolicy)。在前面的课程中，我们看到购买 NFT 首先会返回一个不能丢弃的 TransferRequest：

```move
public fun purchase<T: key + store>(
    self: &mut Kiosk, id: ID, payment: Coin<SUI>
): (T, TransferRequest<T>) {...}
```
为了处理这个 TransferRequest，用户需要调用 `sui::transfer_policy::confirm_request`：

```move
/// 允许类型 `T` 的 `TransferRequest`。该调用受类型约束保护，因为只有 `T` 的发布者才能获得 `TransferPolicy<T>`。  
///注意：除非 `T` 有允许转移的策略，否则 Kiosk 交易将无法进行。

public fun confirm_request<T>(
    self: &TransferPolicy<T>, request: TransferRequest<T>
): (ID, u64, ID) {
    let TransferRequest { item, paid, from, receipts } = request;
    let completed = vec_set::into_keys(receipts);
    let total = vector::length(&completed);

    assert!(total == vec_set::size(&self.rules), EPolicyNotSatisfied);

    while (total > 0) {
        let rule_type = vector::pop_back(&mut completed);
        assert!(vec_set::contains(&self.rules, &rule_type), EIllegalRule);
        total = total - 1;
    };

    (item, paid, from)
}
```
如你所见，`transfer_policy::confirm_request` 会检查请求中是否满足所有“规则”。
请注意，`confirm_request` 需要一个 TransferPolicy，而这个 TransferPolicy 只能通过调用 `transfer_policy::new` 来获得，正如我们在之前的版税课程中看到的那样：

```move
use nft_protocol::royalty;
use nft_protocol::royalty_strategy_bps;
use ob_permissions::witness;
use std::string::{Self, String};
use sui::package;

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
 
    // 定义版税
    let shares = vector[100];
    let creator = tx_context::sender(ctx);
    let shares = utils::from_vec_to_map(creator, shares);
    // 100 BPS (Basis points) == 1%
    royalty_strategy_bps::create_domain_and_add_strategy(
        delegated_witness, &mut collection, royalty::from_shares(shares, ctx), 100, ctx,
    );    

    // 确保版税能轻易被执行
    let publisher = package::claim(otw, ctx);
    let (transfer_policy, transfer_policy_cap) =
        transfer_request::init_policy<KiteNFT>(&publisher, ctx);
    royalty_strategy_bps::enforce(&mut transfer_policy, &transfer_policy_cap);
}
```
这意味着 TransferPolicy 只能由创建者创建，因此创建者可以将其存储在某个地方，并添加一个在检查版税已支付后确认/解决 TransferRequest 的函数。
他们还可以通过调用 `transfer_policy::add_rule` 添加更多规则。

```move
struct TransferPolicyHolder<phantom T> has key {
    id: UID,
    transfer_policy: TransferPolicy<T>,
}

public fun confirm_request(holder: &TransferPolicyHolder, request: TransferRequest<T>) {
    // Verify our rules and add receipts for each confirmed rule to the request.
    
    transfer_policy::confirm_request(&holder.transfer_policy, request);
}
```