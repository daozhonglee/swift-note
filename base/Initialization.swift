//swift 构造方法和析构方法

//================== 构造方法 ==
//Swift语言要求结构体和类必须在构造方法结束前完成其中存储属性的构造（延时存储属性除外）​。
// /

class Myclass {

    var count: Int = 0 {
        willSet {
            print("will set \(newValue)")
        }
    }
    var name: String {
        didSet {
            print("did set \(name)")
        }
    }
    var opt: Int?  //可选类型的属性
    let const: Int  //常量属性  //常量属性也必须在实例构造完成前被构造完成，一旦常量属性被赋值，则不能再被修改
    init() {
        name = "HS"  // 必须要在对存储属性设置默认值或者在构造方法中对其构造时，并不会触发属性监听器，只有在构造完成后，再次对其赋值时才会触发。
        const = 10
    }
}

//和类不同的是，对于结构体，开发者可以不实现其构造方法，编译器会默认生成一个构造方法，将所有属性作为参数
//如果开发者为值类型结构（例如结构体）提供了一个自定义的构造方法，则系统默认生成的构造方法将失效
struct MyStruct {
    var age: Int
    var name: String
    init(age: Int, name: String) {  //如果开发者为值类型结构（例如结构体）提供了一个自定义的构造方法，则系统默认生成的构造方法将失效
        self.age = age
        self.name = name
    }
    init() {  //值类型的构造方法可以嵌套使用
        self.init(age: 10, name: "HS")
    }
}
var s = MyStruct()  //结构体的构造方法

//==================  指定构造方法和便利构造方法==
//指定构造方法不需要任何关键字修饰，便利构造方法需要使用Convenience关键字来修饰
// swift 原则
// 子类的指定构造方法中必须调用父类的指定构造方法。
// 便利构造方法中必须调用当前类的其他构造方法。
// 便利构造方法归根结底要调用某个指定构造方法。
class BaseClass {
    init() {
        print("BaseClass init")
    }
    convenience init(param: String) {
        print("BaseClass convenience init")
        self.init()  //便利构造方法中必须调用当前类的其他构造方法
    }
}
class SubClass: BaseClass {
    override init() {
        print("SubClass init")
        super.init()  //子类的指定构造方法中必须调用父类的指定构造方法
    }
    convenience init(param: String) {
        self.init()  //便利构造方法中必须调用当前类的其他构造方法
    }
    convenience init(param: Int) {
        self.init(param: "HS")  //便利构造方法中必须调用当前类的其他构造方法
    }
}

var obj3 = SubClass()

// =================== 构造方法的继承关系
// 原则
//  在继承关系中，如果子类没有覆写或者重写任何指定构造方法，则默认子类会继承父类所有的指定构造方法。
//  如果子类中提供了父类所有的指定构造方法（无论是通过继承方式还是覆写方式）​，则子类会默认继承父类的便利构造方法。
// 重写和重载
// 覆写是子类对父类的方法重新实现，两者用了同一个方法，但是子类有了自己的功能。重载是使用已有方法相同的方法名，但通过设置不同的参数个数或参数类型来实现新的方法。

class BaseClass2 {
    init() {
        print("BaseClass2 init")
    }
    init(param: Int) {
        print("BaseClass2 init \(param)")
    }
    convenience init(param: String) {
        self.init()
    }
}
//子类没有覆写或者重写任何指定构造方法，则默认子类会继承父类所有的指定构造方法
class SubClsOne: BaseClass2 {}

class SubClsTwo: BaseClass2 {
    override init() {  //覆写无参的构造方法，则不继承父类的其他构造方法
        print("SubClsTwo init")
        super.init()
    }
}

class SubClsThree: BaseClass2 {
    init(param: Bool) {  // 重载了一个新的构造方法，则不再继承其他构造方法
        super.init()
    }
}
class SubClsFour: BaseClass2 {
    override init(param: Int) {  //覆写了所有的指定构造方法，则会默认继承父类的便利构造方法
        super.init(param: param)
    }
    override init() {
        super.init()
    }
}

var c3 = SubClsFour(param: "HS")  //调用父类的便利构造方法

// ===================构造方法的安全性检查
// 在类的构造方法中，编译器会进行4项安全性检查
// 检查1：子类的指定构造方法中，必须完成当前类所有存储属性的构造，才能调用父类的指定构造方法。此检查可以保证：在构造完从父类继承下来的所有存储属性前，本身定义的所有存储属性也已构造完成。
// 检查2：子类如果要自定义父类中存储属性的值，必须在调用父类的构造方法之后进行设置。此检查可以保证：子类在设置从父类继承下来的存储属性时，此属性已构造完成。
// 检查3：如果便利构造方法中需要重新设置某些存储属性的值，必须在调用指定构造方法之后进行设置。此检查可以保证：便利构造方法中对存储属性值的设置不会被指定构造方法中的设置覆盖。
// 检查4：子类在调用父类构造方法之前，不能使用self来引用属性（基类无所谓）​。此检查可以保证在使用self关键字调用实例本身时，实例已经构造完成。
// 例子
class Check {
    var preperty: Int
    init(param: Int) {
        preperty = param
    }
}
class SubCheck: Check {
    var subPreperty: Int
    init() {
        //检查项 1：必须在调用父类的指定构造方法前，完成对本身属性的复制
        subPreperty = 1
        super.init(param: 0)  //检查2：子类如果要自定义父类中存储属性的值，必须在调用父类的构造方法之后进行设置
        preperty = 2
        self.subPreperty = 3  //检查4：子类在调用父类构造方法之前，不能使用self来引用属性
    }
    convenience init(param: Int, subParam: Int) {
        self.init()
        //检查3：便利构造方法中药修改属性的值，必须在调用指定构造方法之后进行设置
        subPreperty = subParam
        preperty = param
    }
}

// ================ 可失败构造方法 ========
// 可失败构造方法是指构造方法在构造过程中可能会失败，返回nil。可失败构造方法的返回值是一个可选类型

class Myclass2 {
    var count: Int
    init?(count: Int) {  //可失败构造方法
        if count < 0 {
            return nil
        }
        self.count = count
    }
}

// 必要构造方法: 必要构造方法是指在子类中必顋实现的构造方法，使用required关键字修饰
class BaseClass3 {
    required init() {
        print("BaseClass3 init")
    }
}
class SubClass3: BaseClass3 {
    required init() {
        print("SubClass3 init")
        super.init()
    }
}

// =================== 析构方法 ========
class MyClass3 {
    deinit {
        print("MyClass3 deinit")
    }
}
