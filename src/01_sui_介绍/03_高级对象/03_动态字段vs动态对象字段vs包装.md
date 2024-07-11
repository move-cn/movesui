## 动态字段 vs 动态对象字段 vs 包装

让我们总结一下到目前为止我们学习的不同对象组合方法：

- **对象包装**：将对象存储在另一个对象中（例如，将 SuiFren 存储在 GiftBox 中）。这会将被包装的对象（SuiFren）从全局存储中移除。链外的 Web 界面在包装后无法查找它们。该对象不再有任何所有者。你可以将其视为将对象转换为普通的非对象结构体实例。

- **动态字段**：也可以用于存储对象。这也会将对象从全局存储中移除。所有权也会被移除。这与对象包装非常相似，只不过字段是动态添加的，而不是在结构体中显式定义的。

- **动态对象字段**：不会将对象从全局存储中移除。所有权会转移到一个特殊的“动态字段对象”，对于 Web 界面来说通常不容易查找。在大多数情况下，这几乎与放弃对象的所有权具有相同的效果。

```move
entry fun wrap_fren(fren: SuiFren, ctx: &mut TxContext) {
    let gift_box = GiftBox {
        id: object::new(ctx),
        inner: fren,
    };
    transfer::transfer(gift_box, tx_context::sender(ctx));
}

// Dynamic fields
public fun color_hat(sui_fren: &mut SuiFren, color: String) {
    if (dynamic_field::exists_(&sui_fren.id, string::utf8(HAT_KEY))) {
        let hat = dynamic_field::borrow_mut(&mut sui_fren.id, string::utf8(HAT_KEY));
        hat.color = color;
    } else {
        dynamic_field::add(&mut sui_fren.id, string::utf8(HAT_KEY), Hat { color });
    }
}

// Dynamic object fields
public fun color_hat(sui_fren: &mut SuiFren, color: String, ctx: &mut TxContext) {
    if (dynamic_object_field::exists_(&sui_fren.id, string::utf8(HAT_KEY))) {
        let hat = dynamic_object_field::borrow_mut(&mut sui_fren.id, string::utf8(HAT_KEY));
        hat.color = color;
    } else {
        let hat = Hat {
            id: object::new(ctx),
            color,
        };
        dynamic_object_field::add(&mut sui_fren.id, string::utf8(HAT_KEY), hat);
    }
}
```

要选择如何组合对象，开发人员应注意以下几点：

- 该字段是否应在结构体中显式定义。这是使用动态字段的一个缺点，因为从对象结构体定义中不容易看到这些字段。这意味着其他开发人员需要通读整个模块的代码，才能找到所有可能添加的动态字段。一般不建议添加超过 10 个单独的动态字段。
- 该对象是否应从全局存储中移除，从而在 Web 界面中不可见。
