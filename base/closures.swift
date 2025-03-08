//swift 闭包

//与函数不同的是，闭包的返回值是可以省略的，在闭包体中，如果有return返回，则闭包会自动将return的数据类型作为返回值类型，上面的闭包代码也可以简写为如下样式：
let closure1 = {(param:Int)->Int in return param+1}

// 用闭包写冒泡排序
var array = [1, 3, 2, 5, 4]

//闭包作为参数传递时的写法优化


import Foundation

// 1. 显式闭包
func testExplicitClosure() {
    let add: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
        return a + b
    }
    print("显式闭包结果: \(add(3, 5))") // 输出: 显式闭包结果: 8
}

// 2. 简化闭包
func testSimplifiedClosure() {
    let add: (Int, Int) -> Int = { a, b in
        return a + b
    }
    print("简化闭包结果: \(add(3, 5))") // 输出: 简化闭包结果: 8
}

// 3. 隐式返回闭包
func testImplicitReturnClosure() {
    let add: (Int, Int) -> Int = { a, b in
        a + b
    }
    print("隐式返回闭包结果: \(add(3, 5))") // 输出: 隐式返回闭包结果: 8
}

// 4. 尾随闭包
func testTrailingClosure() {
    func performOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
        return operation(a, b)
    }
    
    let result = performOperation(3, 5) { a, b in
        a + b
    }
    print("尾随闭包结果: \(result)") // 输出: 尾随闭包结果: 8
}

// 5. 使用 `$` 简化参数
func testDollarSignClosure() {
    let add: (Int, Int) -> Int = {
        $0 + $1
    }
    print("使用 $ 简化参数的结果: \(add(3, 5))") // 输出: 使用 $ 简化参数的结果: 8
}

// 6. 无参数闭包
func testNoParameterClosure() {
    let greeting: () -> String = {
        return "Hello, Swift!"
    }
    print("无参数闭包结果: \(greeting())") // 输出: 无参数闭包结果: Hello, Swift!
}

// 7. 带返回值的闭包
func testClosureWithReturn() {
    let multiply: (Int, Int) -> Int = { a, b in
        return a * b
    }
    print("带返回值的闭包结果: \(multiply(3, 5))") // 输出: 带返回值的闭包结果: 15
}

// 8. 不带返回值的闭包
func testClosureWithoutReturn() {
    let printMessage: (String) -> Void = { message in
        print("消息: \(message)")
    }
    printMessage("这是一个没有返回值的闭包") // 输出: 消息: 这是一个没有返回值的闭包
}

// 9. 带捕获的闭包
func testCapturingClosure() {
    var counter = 0
    let increment: () -> Int = {
        counter += 1
        return counter
    }
    print("第一次调用: \(increment())") // 输出: 第一次调用: 1
    print("第二次调用: \(increment())") // 输出: 第二次调用: 2
}

// 10. 闭包作为函数的返回值
func testClosureAsReturnValue() {
    func getOperation() -> (Int, Int) -> Int {
        return { a, b in
            return a + b
        }
    }
    
    let operation = getOperation()
    print("闭包作为返回值的结果: \(operation(3, 5))") // 输出: 闭包作为返回值的结果: 8
}

// 测试所有方法
func runAllTests() {
    print("开始运行所有闭包测试案例...")
    testExplicitClosure()
    // testSimplifiedClosure()
    // testImplicitReturnClosure()
    // testTrailingClosure()
    // testDollarSignClosure()
    // testNoParameterClosure()
    // testClosureWithReturn()
    // testClosureWithoutReturn()
    // testCapturingClosure()
    // testClosureAsReturnValue()
    print("所有测试案例运行完成！")
}

// 调用测试方法
runAllTests()