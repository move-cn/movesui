## 可组合NFTs

类似于对象，NFTs可以使用我们在前几节课程中学习的不同对象技术组合在一起（“组合”）：

1. **包装（Wrapping）** - 将具有store能力的NFT作为另一个NFT的字段添加。这将从存储中移除子NFT。
2. **动态对象字段（Dynamic object fields）** - 将子NFT添加为动态对象字段。不将其从存储中移除。
3. **动态字段（Dynamic fields）** - 类似于动态对象字段，但子NFT将从存储中移除。
4. **对象拥有对象（Objects owning objects）** - 类似于动态对象字段，但有不同的访问子NFT（`Receiving<T>`）的语法，并保持严格的所有权链。

在这些不同的方法中，使用对象包装是最简单明了的。一个强大的好处是，对于用户界面和游戏来说，哪些NFT可以添加到另一个NFT中是非常清楚的，例如向英雄NFT添加武器、盔甲等。子NFT还可以用来表示NFT的“特征”，例如背景。

```move
struct Background has key, store {
    id: UID,
    type: String,
}

struct Eyewear has key, store {
    id: UID,
    type: String,
}

struct Armor has key, store {
    id: UID,
    defense: u64,
    durability: u64,
}

struct Weapon has key, store {
    id: UID,
    num_uses: u64,
    power: u64,
}

struct Hero has key {
    id: UID,
    background: Background,
    eyewear: Eyewear,
    armor: Armor,
    weapon: Weapon,
}
```

在上面的示例中，Hero 是一个单一的 NFT，它将其他 NFT 作为特定字段包装起来。按照目前的写法，Hero 必须始终拥有所有的子 NFT —— 背景、眼镜、盔甲、武器。如果我们想让盔甲变得可选（例如，一个英雄可以穿或不穿盔甲），我们可以使用 Option 类型：

```move
use std::option::Option;

struct Hero has key {
    id: UID,
    background: Background,
    eyewear: Eyewear,
    armor: Option<Armor>,
    weapon: Weapon,
}

public fun wear_armor(hero: &mut Hero, armor: Armor) {
    option::fill(&mut hero.armor, armor);
}

public fun take_off_armor(hero: &mut Hero) {
    let armor = option::extract(&mut hero.armor);
    transfer::public_transfer(armor, tx_context::sender(ctx));
}
```
然后我们可以使用 `option::fill` 和 `option::extract` 来添加或移除盔甲。

使用这种可组合NFT的好处是，如果我们在市场上出售Hero NFT，所有被包装的物品也会随之一起出售。我们还可以自由移除这些可选的物品，并在我们拥有的不同Hero NFT之间转移它们。可组合NFT可以成为构建丰富游戏和应用程序的非常强大的原语。