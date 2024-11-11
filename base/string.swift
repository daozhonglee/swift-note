//字符串常用操作

var s:String = "hello"
var s1:String = "world"
var c3 = s + s1


var d = "hello \(123)"
var d2: String = "hello \(s1)"
var d3 = "hello \(1+1)"


//字符常见操作

var c:Character = "a"
print(c)

var m1 = MemoryLayout<String>.size
print(m1)

var e:Character = "b"
var e2:[Character] = ["a","b","c"]
var e3 = String(e2)
var e4 = Character("a")
print(e)
print(e2)
print(e3)
print("e4:\(e4)")
print("=====")


for c in e2 {
    print(c)
}

//字符串类型常用方法
var obj1 = ""
if obj1.isEmpty {
    print("obj1 is empty")
    print("obj1 length is \(obj1.count)")
}

var s5 = "hello swift"
var startIndex = s5.startIndex
var endIndex = s5.endIndex
print("startIndex:\(startIndex)")
print("endIndex:\(endIndex)")

var char = s5[s5.index(after: startIndex)]
var char2 = s5[s5.index(before: endIndex)]
print("char:\(char)")
print("char2:\(char2)")


var subStr = s5[startIndex..s5.index(after: startIndex, offsetBy: 4)]
var subStr2 = s5[s5.index(endIndex, offsetBy: -5)..<s5.endIndex]
print(subStr)
print(subStr2)


var range = string.range(of:"hello")
print(range)