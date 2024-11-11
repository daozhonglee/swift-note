//swift 结构体

//在 swif 中，结构体属于值类型，值类型在传递的时候会被复制，而不是传递引用，这与类不同，类是引用类型
struct Student{
    var name:String
    var age:Int
    var score:Int

    mutating func drive(){
        print("drive")
    }
}

//在创建结构体后，结构体会默认生成一个构造方法供开发者使用，开发者可以在构造方法中完成对结构体的实例化
var stu = Student(name: "tian", age: 18, score: 100)
print( "name is \(stu.name), age is \(stu.age), score is \(stu.score)" )
