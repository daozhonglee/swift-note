// swift 协议

// ================protocol
// Swift语言中的协议使用protocol关键字来创建，其中可以声明属性与方法。其中属性在具体实现时可以是计算属性，也可以是存储属性
protocol ProtocolNew {
    var name: String { get }  //当协议中约定的属性是可读时，并非只读的意思，它在实现中可以是只读的，也可以是可读可写的。
    var age: Int { get set }  //如果协议中约定的属性为可读可写，则在实现时其必须是可读可写的
    var nameAndAge: String { get }
    static var className: String { get }  //静态属性
    func logName()  // 声明实例方法
    static func logClassName()  // 声明类方法
}

class ClassNew: ProtocolNew {
    func logName() {}

    static func logClassName() {}

    var name: String
    var age: Int
    var nameAndAge: String {
        return "\(name) \(age)"
    }
    static var className: String {
        return "ClassNew"
    }
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

func test(param: ProtocolNew) {
    print(param.name)
    print(param.age)
    print(param.nameAndAge)
    param.logName()
}
