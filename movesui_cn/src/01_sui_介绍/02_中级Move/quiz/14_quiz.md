## 在下例中：
```move
struct MyData has key {
    id: UID,
    value: u64,
}

public fun set_value(object_1: &MyData, object_2: &MyData, value: u64) {
    object_2.value = value;
}
```

## 如果 object_1 是一个共享对象，object_2 是一个归属对象，那么谁可以发送这个交易？

A. 任何人  
B. object_1 的所有者  
C. object_2 的所有者