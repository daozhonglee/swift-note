//swift 高级运算符



//位运算
var a:UInt = 0b1000 //声明一个无符号整型变量a，并赋值为二进制数1000
var b = ~a //对a进行按位取反操作
var c = a&b //对a和b进行按位与操作
var d = a|b //对a和b进行按位或操作
var e = a^b //对a和b进行按位异或操作
var f = a<<1 //对a进行左移1位操作
var g = a>>1 //对a进行右移1位操作


//溢出运算
var h = UInt8.max //声明一个UInt8类型的变量，并赋值为UInt8的最大值
var i = h &+ 1 //对h进行加1操作，由于h的值已经达到了UInt8的最大值，所以会发生溢出，但是由于使用了&+运算符，所以不会报错，而是将结果截断为0


//运算符重载
func add(a: Int, b: Int) -> Int{
    return a + b
}
func add(a: Double, b: Double) -> Double{ //函数重载
    return a + b
}

class Circle{
    var radius: Double
    init(radius: Double){
        self.radius = radius
    }
}
func +(a: Circle, b: Circle) -> Circle{ //运算符重载
    return Circle(radius: a.radius + b.radius)
}


//自定义运算符
//在进行运算符的实现时，后缀和前缀运算符只能有一个参数，参数在func关键字前需要表明要实现的运算符类型，而中缀运算符需要有两个参数且func关键字前不需要额外标明，运算符的优先级可以通过infix关键字来指定，同时还可以通过precedencegroup关键字来定义运算符的优先级组
prefix operator +++ //定义一个前缀运算符
prefix func +++(a: Int) -> Int{
    return a + 1+1+1
}
var j = 1
j = +++j
print(j)

infix operator **: MultiplicationPrecedence //定义一个中缀运算符
func **(a: Int, b: Int) -> Int{
    return a * b
}

postfix operator *** //定义一个后缀运算符
postfix func ***(a: Int) -> Int{
    return a * a
}