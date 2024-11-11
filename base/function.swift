//swift function

func sayHello(personName: String) -> String{
    let greeting = "Hello, " + personName + "!"
    return greeting
}

print(sayHello(personName: "tian"))


//返回值可以省略名称，但是参数名称不能省略
func emptyFunc() -> String{ 
    return "Hello"
}

func myFunc2(param1: Int,param2: Int){
    print(param1)
    print(param2)
}

print(emptyFunc())

func emptyFunc2(){
    print("Hello")
}
emptyFunc2()

//多返回值函数
func mutliReturnFunc() -> (Success:Int, Status:Int){
    return (1, 2)
}
let a = mutliReturnFunc().0
let b: Int = mutliReturnFunc().Status
print(a)
print(b)

//Swift语言中的函数还有一个使用技巧，开发者可以通过返回Optional类型值来标识函数的执行是否成功，在调用函数时使用if-let结构进行安全性检查
func minMax(array: [Int]) -> (min: Int, max: Int)?{
    if array.isEmpty {return nil}
   
    return (array[0], array[1])
}
if let tmp = minMax(array: [1, 2, 3, 4, 5]){
    print("min is \(tmp.min), max is \(tmp.max)")
}

//函数参数名，内部命名，外部命名
func someFunction(firstParameterName: Int, secondParameterName: Int){
    print(firstParameterName)  //函数内部使用的是函数的内部命名
    print(secondParameterName)
}
someFunction(firstParameterName: 1, secondParameterName: 2) //函数外部使用的是函数的外部命名，默认情况下，函数的外部命名和内部命名是一样的

//在声明函数时，也可以在内部命名的前面再添加一个名称作为参数的外部命名
func myFunc(paramOutName1 paramInName1: Int, paramOutName2 paramInName2: Int){
    print(paramInName1)
    print(paramInName2)
}

//Swift语言也支持省略函数参数的外部名称，默认函数参数的外部名称与内部名称相同，开发者可以使用匿名变量标识符“_”来对外部名称进行省略，示例如下
func someFunc(_ firstParameterName: Int, secondParameterName: Int){
    print(firstParameterName)
    print(secondParameterName)
}
someFunc(1, secondParameterName: 2)

//默认参数值
func someFunc2(param: Int, param2:Int=2){
    print(param)
    print(param2)
}

//不定参数值
func someFunc3(numbers:Int..., strings:String..., flag:Bool)->Int{
    print(numbers)
    print(strings)
    print(flag)
    return 1
}

//对于值类型参数，如果开发者在函数内部修改参数的值，编译器会直接报错, 如果想修改，需要修改为inout类型
func someFunc4(param:inout Int){
    param += 2
}
var param1 = 1
someFunc4(param: &param1) //在传参时需要使用“&”符号，这个符号将传递参数变量的内存地址


print("==================")

//函数类型
var addFunc:(Int,Int)->Int 
addFunc = { (param1:Int, param2:Int)in return param1+param2} //in是闭包的关键字，表示闭包的开始
print(addFunc(1, 2))

//函数作为参数
func funcaAsParam(param1:Int, param2:(Int, Int)->Int)->Int{
    return param2(param1, 2)
}

