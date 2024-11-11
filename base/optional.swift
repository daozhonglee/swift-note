
//swift 可选项

var optionalString: String? = "Hello"

print(optionalString!)

//区间运算符
var range1 = 1...5 //闭区间运算符
var range2 = 1..<5 //半开区间运算符

print(range1 ~= 8 ) //判断8是否在range1区间内

print(1111)
for i in 0...3{
    print(i)
}

for _ in 0...3{
    print("hello")
}


//while循环
while true {
    print("hello")
    break
}

//repeat-while循环
repeat {
    print("hello")
} while false