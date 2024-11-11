//swift 枚举




enum Surname{
    case tian
    case li
    case zhang
    case wang
}

enum Surname2{
    case tian, li, zhang, wang
}

var sur:Surname = .tian
var sur2 = Surname.tian

//枚举的原始值
enum CharEnum:Character{ //为枚举类型指定原始值类型
    case a = "a" //通过赋值的形式为枚举值指定原始值
    case b = "b"
    case c = "c"
}

//如果指定枚举的原始值为 int 类型，那么后续的枚举值会依次递增
enum IntEnum:Int{
    case a = 1
    case b
    case c
}

var c = CharEnum.a
var c2 = c.rawValue //通过rawValue属性获取枚举值的原始值
print(c)
print( c2 )

//枚举的相关值
enum Student{
    case name(firstName:String, lastName:String)  //在定义枚举值的时候，开发者可以为其设置一个参数列表，这个参数列表被称为枚举的相关值，相关值可以是任意类型
    case score(Int)
    case age(Int)
}

var stu = Student.name(firstName: "tian", lastName: "li")
func select(stu:Student){
    switch stu {
    case .name(let firstName, let lastName): //在switch语句中，通过case语句的模式匹配，可以将枚举值的相关值绑定到case语句的变量中
        print("name is \(firstName) \(lastName)")
    case .score(let score):
        print("score is \(score)")
    case .age(let age):
        print("age is \(age)")
    }
}