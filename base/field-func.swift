import Foundation

//swift 方法和属性

class Student {
    var name: String
    var age: Int  //变量存储属性
    let set: String  //常量存储属性
    var schoolName: String = "CUG"  //默认值
    init(name: String, age: Int, set: String) {
        self.name = name
        self.age = age
        self.set = set
    }
}

//需要注意，变量类型的属性可以修改，常量类型的属性不可修改。但是对于值类型实例，如果实例是常量接收的，则其中变量的属性也不可以修改。而对于引用类型实例，无论实例是变量还是常量接收的，都可以修改变量类型的属性
struct Point {
    var x: Int
    var y: Int
}
class PointC {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

let point = Point(x: 1, y: 2)
// point.x = 3  //fatal 值类型实例，如果实例是常量接收的，则其中变量的属性也不可以修改, 这里会保存

let pointC = PointC(x: 1, y: 2)
pointC.x = 3  // 引用类型实例，无论实例是变量还是常量接收的，都可以修改变量类型的属性

//=====
//Swift语言支持将存储属性设置为延时存储属性。所谓延时存储属性，是指在类实例构造的时候，延时存储属性并不进行构造或初始化，只有当开发者调用类实例的这个属性时，此属性才完成构造或初始化操作
//延时存储属性并不是线程安全的，如果在多个线程中对延时存储属性进行调用，不能保证其只被构造一次
class Work {
    var name: String
    init(name: String) {
        self.name = name
        print("Work init")
    }
}

class People {
    var age: Int
    lazy var work: Work = Work(name: "teacher")
    init(age: Int) {
        self.age = age
        print("People init")
    }
}
var people = People(age: 10)  //初始化 people 并不会init work 类的构造信息
print(people.work)  //调用work 属性才完成 work 示例的构造

//==================计算属性 =====
// Swift语言中提供了计算属性，用来描述这种可以由其他属性通过计算而得到的属性
// 需要注意，在计算属性的set方法中，会将外界所设置的值默认以newValue的名字传入
// 需要注意，在计算属性的set方法中，会将外界所设置的值默认以newValue的名字传入
class Circle {
    var radius: Double
    var center: (Double, Double)
    var length: Double {
        get {
            return 2 * 3.14 * radius
        }
        set {
            radius = newValue / (2 * 3.14)
        }
    }
    var area: Double {
        return radius * radius * Double.pi  //只读的计算属性写法可以进行简化
    }
    init(radius: Double, center: (Double, Double)) {
        self.radius = radius
        self.center = center
    }
}
var c = Circle(radius: 10, center: (0, 0))
print("=====")
print(c.length)
print("=====")

//==================属性监听器 =====
// Swift语言为存储属性提供了属性监听器，以便让开发者赋值属性时执行额外操作。
// 需要注意，在进行属性的构造或初始化时，无论是通过构造方法进行属性构造或初始化，还是为属性设置默认值，都不会调用属性监听器的方法。初始化后从第2次为属性赋值开始，属性监听器才会被调用
class Teacher {
    var name: String {
        willSet {
            print("will set \(newValue)")  //默认生成一个newValue的参数
        }
        didSet(old) {
            print("did set \(old)")  // 也支持自己定义属性监听器方法的参数名称
        }
    }
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

var t = Teacher(name: "zhang", age: 10)  //初始化不会调用属性监听器
t.name = "li"  //从第2次为属性赋值开始，属性监听器才会被调用
// warn: 只有存储属性可以设置属性监听器，计算属性不可以。

// ==================属性包装器 =====
@propertyWrapper
struct MoreThanZero {  //定义属性包装器
    private var number: Int
    init() {
        self.number = 0
    }
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            if newValue > 0 {
                self.number = newValue
            } else {
                number = 0
            }
        }
    }
}

@propertyWrapper
struct NotEmptyString {  //定义属性包装器
    private var value: String
    init() {
        self.value = ""
    }
    var wrappedValue: String {
        get {
            return value
        }
        set {
            if newValue.isEmpty {
                value = "default"
            } else {
                value = newValue
            }
        }
    }
}

class Member: CustomStringConvertible {
    private var name: String
    private var age: Int
    init() {
        self.name = "defaul"
        self.age = 0
    }
    @NotEmptyString var memberName: String
    @MoreThanZero var memberAge: Int
    var description: String {
        return "name: \(self.memberName), age: \(self.memberAge)"
    }
}

let member1 = Member()
member1.memberName = ""
member1.memberAge = -1
print(member1)

//==================实例属性和类属性 =====
// 实例属性是与具体实例相关联的，一般用来描述类实例的一些特性, 类属性是与此类型相关联的，用来描述整个类型的某些特性。
// 类属性使用static或者class关键字来声明。使用static关键字声明的属性也被称为静态属性，需要注意，对于类的计算属性，如果允许子类对其计算方法进行覆写，则需要用class关键字来声明，
class SomeClass {
    static var className = "SomeClass"
    static var subName: String {
        return "sub" + className
    }
    class var classSubName: String {
        return "class" + subName
    }
}

print(SomeClass.className)  //类属性不需要创建实例对象，直接通过类名访问
print(SomeClass.subName)
print(SomeClass.classSubName)

class SubClass: SomeClass {
    //对计算方法进行覆写
    override class var classSubName: String {
        return "override" + super.classSubName
    }
}
print(SubClass.classSubName)

//================== 实例方法和类方法=====
// 实例方法是与具体实例相关联的，一般用来描述类实例的一些行为，类方法是与此类型相关联的，用来描述整个类型的某些行为。
class Math {
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    func sqr(param1: Int, param2: Int) -> Int {
        return self.add(a: param1, b: param2) * self.add(a: param1, b: param2)
    }
}
var obj = Math()
print(obj.add(a: 1, b: 2))
print(obj.sqr(param1: 1, param2: 2))

// 一般情况下，self是可以被省略的，开发者直接通过方法名来调用自身的实例方法也是没问题的。有一种情况读者需要注意，在对实例属性进行调用的时候，有时候属性名称可能会和方法中的参数名称相同，这时为了避免歧义，实例属性前的self不能够省略

//Swift语言中的类型有值类型与引用类型之分，对于引用类型，在实例方法中对实例属性进行修改是没问题的。但是对于值类型，读者需要格外注意，使用mutating关键字修饰实例方法才能对属性进行修改
struct Point2 {
    var x: Int
    var y: Int
    mutating func move(x: Int, y: Int) {  //使用mutating关键字修饰实例方法才能对值类型的属性进行修改
        self.x += x
        self.y += y
    }
    static let name = "Point2"
    static func printName() {  //static关键字声明的类方法又被称为静态方法，其不能被子类覆写，而class关键字声明的类方法可以被类的子类覆写。
        print(self.name)
    }
}
var p = Point2(x: 1, y: 2)
p.move(x: 3, y: 3)
print(p.x, p.y)

//===============类方法 =====
//=============== 下标方法 =====
class MyArray {
    var array: [Int]
    init(array: [Int]) {
        self.array = array
    }

    subscript(index: Int) -> Int {
        get {
            return array[index]
        }
        set {
            array[index] = newValue
        }
    }
}

var myArray = MyArray(array: [1, 2, 3])
myArray[2] = 4
myArray[0] = 0
print(myArray[0], myArray[1], myArray[2])
