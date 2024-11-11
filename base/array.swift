//数组

//声明数组
var arr1:[Int]
var arr2:Array<Int>

//初始化数组
arr1 = []
arr2 = Array()

//创建整型数组
arr1 = [1,2,3,4,5]
print(arr1)

//通过一组元素初始化数组
arr2 = Array(arrayLiteral: 1,3,5)
print(arr2)

//通过重复元素初始化数组
var arr3 = [String](repeating: "Hello", count: 3)
print(arr3)

var arr5 = [1,2,3,4,5] + [6,7,8,9,10]
print(arr5)
print(arr5.count)
print(arr5.isEmpty)
print(arr5[0...3])
// print(arr5.first)
// print(arr5.last)

arr5[0]=999
var idx0:Int? = arr5.first 
var idx_1:Int? = arr5.last
print(idx0!)

//追加元素
arr5.append(100)

//某个位置插入一组元素
arr5.insert(contentsOf: [11,22,33], at: 2)
print(arr5)

arr5.insert(0,at:0)
print(arr5)

arr5.remove(at: 0)
print(arr5)

print(arr5.removeFirst())
print(arr5.removeLast())


//遍历数组,获取元素
for item in arr5 {
    print(item)
}

//遍历数组，获取索引和元素
for (index,item) in arr5.enumerated() {
    print("index:\(index) item:\(item)")
}