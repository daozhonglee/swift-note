//swift 闭包

//与函数不同的是，闭包的返回值是可以省略的，在闭包体中，如果有return返回，则闭包会自动将return的数据类型作为返回值类型，上面的闭包代码也可以简写为如下样式：
let closure1 = {(param:Int)->Int in return param+1}

// 用闭包写冒泡排序
var array = [1, 3, 2, 5, 4]

//闭包作为参数传递时的写法优化
