import UIKit

// MARK: ============= 常量与变量
// 1. 一般先定义为常量，需要修改时，再改为变量
var a = 30
a = 39

// 2. 使用swift关键字
let `var` = 30
`var`


// MARK: ============= 基本数据类型与运算符
/**
 整型/浮点型/Bool型/元组/枚举/结构体/类等
 类型安全，在编译阶段执行类型判断，并报错 （option键 + 左键，查看类型）
 只有类型相同才可以运算，swift中没有隐式类型转换
 */
// 类型别名
typealias IntAlias = Int
let a1: IntAlias = 30

// 区间运算符
0..<10 //0~9
0...10 //0~10

// 包含的两种表达
let bool1 = (0..<10).contains(10)
let bool2 = (0...10) ~= 10

// 空合运算符
var name: String? = "Yoyo"
// 如果name有值就强制解包并返回，如果没有则返回右边的值
let result = name ?? "张三"


// 强势解包
let view1: UIView? = UIView()
if view1 != nil {
    view1!.backgroundColor = .red
}
