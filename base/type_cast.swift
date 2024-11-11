// swift 类型转换

// =================== 类型检查

var str = "str"
if str is String {
    print("str is String")
}

//  向下转换 对于有继承关系的类，类型检查有如下原则：子类实例进行父类类型的检查可以检查成功。父类实例进行子类类型的检查不可以检查成功。
class BaseClass {}
class SubClass: BaseClass {}

var cls1 = BaseClass()
var cls2 = SubClass()

if cls1 is BaseClass {
    print("cls1 is BaseClass")
}
if cls2 is BaseClass {
    print("cls2 is BaseClass")
}
if cls1 is SubClass {
    print("cls1 is SubClass")
} else {
    print("cls1 is not SubClass")
}

// ================== 类型转换
class Myclass: BaseClass {
    var name: String?
}
class MySubclassOne: Myclass {
    var count: Int?
}
class MySubclassTwo: Myclass {
    var isBiger: Bool?
}
var o1 = Myclass()
o1.name = "o1"
var o2 = MySubclassOne()
o2.count = 10
var o3 = MySubclassTwo()
o3.isBiger = true

var arr: [Myclass] = [o1, o2, o3]
for var i in 0..<arr.count {
    var obj = arr[i]
    if obj is MySubclassOne {
        print((obj as! MySubclassOne).count)
        continue
    }
    if obj is MySubclassTwo {
        print((obj as! MySubclassTwo).isBiger)
        continue
    }
    if obj is Myclass {
        print(obj.name!)
    }
}
