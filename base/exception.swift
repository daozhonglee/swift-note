//异常管理
enum myError: Error {
    case error1
    case error2
    case error3
}
print("should error")
// throw myError.error1 //抛出异常
print("finish")

func throwError() throws {
    throw myError.error1
}

do {
    try throwError()
} catch myError.error1 {
    print("Caught error1")
} catch myError.error2 {
    print("Caught error2")
} catch myError.error3 {
    print("Caught error3")
} catch {
    print("Caught an unknown error")
}

// ==============异常处理 2
// 有些时候开发者可能并不关心产生异常的类型与原因，只需要知道有没有产生异常，对于这种情况，使用do-catch结构会显得十分烦琐冗余。Swift语言还提供了另一种方法，可以将异常映射为Optional值，如果函数正常运行，没有抛出异常，则正常返回；如果函数执行出错，抛出了异常，则会返回Optional值nil。使用try?来调用函数可以将异常映射为Optional值
func throwError2() throws -> String {
    throw myError.error1
    return "Success"
}
var tmp = try? throwError2()
if tmp == nil {
    print("error")
} else {
    print("no error")
}

// ==============异常处理 3
//当开发者可以保证此函数一定不会抛出异常时，便可以使用try!来强行终止异常的传递，然而这么做有一定的风险，如果这个函数真的抛出了异常，则会产生运行时错误
try! throwError2()
