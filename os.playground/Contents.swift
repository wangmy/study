import Cocoa


extension Array {
    public subscript(safe index: Int) -> Element? {
        if self.count > index {
            return self[index]
        }
        return nil
    }
    
    mutating func remove(safeAt index: Int) {
        if count > index {
            remove(at: index)
        }
    }
    
}
var array1 = [1,2,3]
let item = array1[safe: 6]
item

array1.remove(safeAt: 4)
array1


// MARK: sort
func testSort() {
    var array1 = ["Animal", "Baby", "Apple", "Google", "Aunt"]
    array1.sort()
    let array2 = ["Animal", "Baby", "Apple", "Google", "Aunt"]
    array2.sorted()

    /**
     1. 默认是升序
     2. sorted 返回一个新的集合
     3. sort 直接在原来的集合上操作
     */

    //降序
    array1.sort() { (str1, str2) in
        return str1 > str2 // 9times
    }
    array2.sorted() { (str1, str2) in
        return str1 > str2
    }

    //降序 简写
    array1.sort { return $0 > $1 } // 10times
    array2.sorted { return $0 > $1 }
}

// MARK: forEach
func testForEach() {
    let array1 = ["Animal", "Baby", "Apple", "Google", "Aunt"]
    array1.forEach { str in print(str) }
    array1.forEach { print($0) }
}


// MARK: filter & first(where:) & last(where:) & removeAll(where:)
func testFilter() {
    var array1 = ["Animal", "Baby", "Apple", "Google", "Aunt"]
    /**
     筛选里面的闭包必须返回Bool， 筛选出返回true的元素
     */
    array1.filter { str in
        str.hasPrefix("A")
    }.forEach{ print($0) }

    array1.filter { $0.hasPrefix("A") }.forEach{ print($0) }
    
    // 筛选出第一个符合条件的元素
    let ele1 = array1.first { $0.hasPrefix("G") }
    ele1
    // 筛选出随后一个符合条件的元素
    let ele2 = array1.last { $0.hasPrefix("B") }
    ele2
    //删除符合条件的元素
    array1.removeAll { $0.hasPrefix("A") }
    array1
}

// MARK: allSatisfy
func testAllSatisfy() {
    /**
     检查序列中所有元素是否满足条件，全部满足才返回true
     */
    let scores = [86, 88, 95, 90]
    let passed = scores.allSatisfy {
        $0 > 80
    }
    passed
}

// MARK: map & compactMap & mapValues & compactMapValues
func testMap() {
    /**
     闭包返回一个变换后的元素，所有变换后的元素组成一个新的集合
     */
    let newStr = "test".map { "\($0) - new" }
    newStr

    let array3 = ["array1","array2","array3","array4","array5"]
    let array3New = array3.map { "\($0)-new" }
    array3 // ["array1", "array2", "array3", "array4", "array5"]
    array3New // ["array1-new", "array2-new", "array3-new", "array4-new", "array5-new"]

    let dic = ["key1": "value1"]
    let dicNew = dic.map { ["\($0.key)-new" : "\($0.value)-new"] }
    dic // ["key1": "value1"]
    dicNew // [["key1-new": "value1-new"]]

    /**
     compactMap 可以过滤掉空元素
     compactMap(flatMap 被废弃了) 可以过滤掉空元素,
     */
    let array4 = ["array1","array2", nil ,"array4","array5"]
    let list1 = array4.map { $0 }
    list1 // ["array1", "array2", nil, "array4", "array5"]
    let list2 = array4.compactMap { $0 }
    list2 // "array1", "array2", "array4", "array5"]

    /**
     mapValues & compactMapValues 专门用于字典
     */
    let dic1 = ["1": "1", "2": "2", "3": "3", "4": "r", "5": "5"]
    /**
     mapValues类似数组中的map，只是专门针对字典的values, mapValues 返回的还是一个字典
     如果在字典上用map，返回的是数组（key/value）
     
     compactMapValues 类似数组中的compactMap，过滤掉不符合条件的内容，只是专门针对字典的values, compactMapValues 返回的还是一个字典
     如果在字典上用compactMap，返回的是数组（key/value）
     */
    let result1 = dic1.mapValues { Int($0)}
    result1 // ["4": nil, "5": 5, "3": 3, "1": 1, "2": 2]
    let result2 = dic1.map { Int($0.value)} // [nil, 5, 3, 1, 2]
    result2
    let result3 = dic1.compactMapValues { Int($0) } // ["2": 2, "1": 1, "3": 3, "5": 5]
    result3
    let result4 = dic1.compactMap { Int($0.value) } // [5, 2, 3, 1]
    result4
}

// MARK: reduce 把多个元素的值合并为一个新的值
func testReduce() {
    
    let sum = [1, 3, 3, 4]
    let start = 102
    
    /**
     可以把多个元素的值合并成一个新的值
     start: 设置初始状态
     result: 中间结果
     num: 集合中的每个元素
     */
    //直接返回结果
    let total = sum.reduce(start) { result, num -> Int in
        print("result \(result); num \(num)")
        return result+num
    }
    total // 113
    
    //不返回结果
    var into = 102
    let total2 = sum.reduce(into: into) { result, num in
        print("result \(result); num \(num)")
        into += num
        print("into \(into)")
    }
    into // 113
    total2 // 102
    
    //简写1
    let total3 = sum.reduce(start) { $0 + $1}
    total3 // 113
    
    //简写2
    let total4 = sum.reduce(start, +)
    total4 // 113
    
    //字符串 reduce
    let total5 = ["a","b","c"].reduce("1", { $0 + ", " + $1})
    total5 // "1, a, b, c"
    
    let dic = ["1": "value1", "2": "value2", "3": "value3", "4": "valuer", "5": "value5"]
    let reduceResult = dic.reduce("======") { (result, item: (key: String, value: String)) -> String in
        result + item.value
    }
    reduceResult // "======value2value3value5value1valuer"
    
}
//testReduce()

// MARK: 组合方法
func comminMethod() {
    let array1 = ["Animal", "Baby", "Apple", "Google", "Aunt"]
    array1
        .sorted{ $0 > $1}
        .filter { $0.hasPrefix("A")}
        .forEach { print($0) }
}
comminMethod()

// MARK: isDisjoint
let string = "缅甸字符缅甸字符缅甸字符缅甸字符缅甸字符ꩵ"
let specialCharacterSet: Set<Character> = ["ꩵ", "𓆏"]
if !specialCharacterSet.isDisjoint(with: string) {
    print("🌹")
}

// MAKR: 应用
// 1. 数字转数组
extension Int {
    var array: [Int] {
        return String(self).compactMap { Int(String($0)) }
    }
}
123.array


func testEnum() {
    // enum 默认没有原始值
    enum Test1: Int {
        case test1,test2,test3
    }
    
    Test1.test1.rawValue
    
    // 枚举遍历 CaseIterable
    enum Method: CaseIterable {
        case method1, method2, method3, method4
    }
    Method.allCases.forEach { print($0) }
    
    //enum 可以设置关联值
}

testEnum()










