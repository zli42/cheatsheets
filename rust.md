# Rust

## 所有权

* 大小固定的变量 (例如字符串字面值) 放在 "栈" 中, 速度快
* 大小不固定的变量 (例如 `String` 类型) 放在 "堆" 中, 速度慢

变量离开作用域, 则被垃圾回收

变量移动, 伴随着权限移动, 原变量失去所有权, 不可再使用

* 整数 / 布尔 / 浮点 / 字符类型的变量移动时, 自动 `copy` 在栈上
* 其他变量移动, 若要保持原变量可用, 需要使用 `clone` 在堆上复制

可以通过 `&` (引用), 在不转移所有权的条件下使用原变量. 若要修改原变量, 注意变量和引用都要变为 `mut` (可变)

* 要么只能由一个可变引用, 要么只能有多个不可变引用
* 引用必须总是有效

## Vector

不能在相同作用域中同时存在可变和不可变引用

```rust
// 以下代码会报错
fn main() {
    let mut v = vec![1, 2, 3, 4, 5];

    let first = &v[0];

    v.push(6);

    println!("The first element is: {}", first);
}
```
在 vector 的结尾增加新元素时，在没有足够空间将所有元素依次相邻存放的情况下，可能会要求分配新内存并将老的元素拷贝到新的空间中。这时，第一个元素的引用就指向了被释放的内存。

遍历 vector:
```rust
fn main() {
    let mut v = vec![100, 32, 57];
    for i in &mut v {
        *i += 50;  //使用解引用运算符（*）获取 i 中的值
    }
}
```

## 字符串

* 字符串slice `str`，它通常以被借用的形式出现 `&str`
* `String` 是可增长的、可变的、有所有权的、UTF-8 编码的字符串类型

字符串 slice 是 `String` 中一部分值的引用
``` rust
    let s = String::from("hello world");
    let hello = &s[0..5];
```

字符串字面值就是 slice
```rust
let s = "Hello, world!";
```
`s` 的类型是 `&str`, 它是一个指向二进制程序特定位置的 slice, 是一个不可变引用. 这也就是为什么字符串字面值是不可变的.

best practice
```rust
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}

fn main() {
    let my_string = String::from("hello world");

    // `first_word` 适用于 `String`（的 slice），整体或全部
    let word = first_word(&my_string[0..6]);
    let word = first_word(&my_string[..]);

    // `first_word` 也适用于 `String` 的引用，
    // 这等价于整个 `String` 的 slice
    let word = first_word(&my_string);


    let my_string_literal = "hello world";

    // `first_word` 适用于字符串字面值，整体或全部
    let word = first_word(&my_string_literal[0..6]);
    let word = first_word(&my_string_literal[..]);

    // 因为字符串字面值已经 **是** 字符串 slice 了，
    // 这也是适用的，无需 slice 语法！
    let word = first_word(my_string_literal);
}
```

## 智能指针

* 引用 `&` 借用他们所指向的值
* 智能指针表现类似指针，但是也拥有额外的元数据和功能

常用的智能指针:
* `Box<T>`，用于在堆上分配值. 它们多用于如下场景：
    * 当有一个在编译时未知大小的类型，而又想要在需要确切大小的上下文中使用这个类型值的时候 (递归)
    * 当有大量数据并希望在确保数据不被拷贝的情况下转移所有权的时候 (数据在堆上, 仅拷贝在栈上指向堆的指针)
    * 当希望拥有一个值并只关心它的类型是否实现了特定 trait 而不是其具体类型的时候 (trait 对象)
* `Rc<T>`，一个引用计数类型，其数据可以有多个所有者, 只能提供数据的不可变访问
* `Weak<T>`, 用来避免引用循环造成的内存泄漏
* `RefCell<T>` 是一个在运行时而不是在编译时执行借用规则的类型, 提供了一个可以用于当需要不可变类型但是需要改变其内部值能力的类型, 只允许有多个不可变借用或一个可变借用之一
    * `borrow` 方法返回 `Ref<T>` 类型的智能指针
    * `borrow_mut` 方法返回 `RefMut<T>` 类型的智能指针