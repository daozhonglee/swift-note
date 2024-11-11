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
