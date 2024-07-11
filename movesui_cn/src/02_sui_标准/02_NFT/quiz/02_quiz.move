/*
让我们从这节课开始，尝试为 SuiFrens 创建我们自己的简单 NFT 标准。定义两个独立的对象结构体，一个用于 SuiFrenCollection，一个用于 SuiFren（作为 NFT），并包含以下属性：

SuiFrenCollection 对象结构体：
1. creator 类型为 address
2. name 类型为 String
3. description 类型为 String
4. limit 类型为 u64
5. url 类型为 sui::url::Url

SuiFren NFT 对象结构体：
1. collection 类型为 address
2. name 类型为 String
3. url 类型为 sui::url::Url
4. attributes 类型为 vector<String>

提示：不要忘记导入
*/

module sui::sui_fren {
    // 这里添加结构体
}