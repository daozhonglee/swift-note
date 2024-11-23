// swift extension

class MyClass {
    var name: String
    var age: Int
    init() {
        name = "name"
        age = 0
    }
}
extension MyClass {  //为MyClass添加一个扩展
    var nameAndAge: String {
        return "\(name) \(age)"
    }
    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
    }
    class func logClassName() {
        print("MyClass")
    }
}

var obj = MyClass()
print(obj.nameAndAge)
MyClass.logClassName()

extension Int {  //
    mutating func change() {  //对值类型进行扩展，可以使用mutating关键字修饰来修改当前实例本身
        self = self * self
    }
}
var count = 3
print("count:\(count.change())")

// 可以使用扩展来遵守一个协议
protocol MyProtocol {
    func log()
}
extension MyClass: MyProtocol {
    func log() {
        print("MyProtocol")
    }
}
var cls = MyClass()
cls.log()
