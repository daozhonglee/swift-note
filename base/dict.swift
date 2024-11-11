//字典

//声明字典
var dict:[Int:String]
var dict2:Dictionary<Int,String> //和 1 一样，另一种表达方式

dict1 = [1:"one",2:"two",3:"three"]
dict2 = Dictionary(dictionaryLiteral: (1,"one"),(2,"two"),(3,"three"))

var dict3 = [1:"one",2:"two",3:"three"] //编译器自动推断类型

var dict4 = [:] //空字典
var dict5 = Dictionary<Int,String>() //空字典

//字典元素个数
print(dict1.count)
print(dict1.isEmpty)

dict1.removeValue(forKey: 1)
dict1.removeAll()

//遍历字典
//遍历字典的键和值
print(111111111)
for (key,value) in dict {
    print("key:\(key) value:\(value)")
}

//遍历字典的键
print(222222222)
for key in dict.keys {
    print(key)
}

//遍历字典的值
print(333333333)
for value in dict.values {
    print(value)
}