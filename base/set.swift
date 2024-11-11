//集合类型

var set1: Set = [1, 2, 3, 4, 5]
var set2 = Set(arrayLiteral: 1,2,3,4)
var set3 = Set([1,2,3,4,5,6,7,8,9,10])

print(set1.count)
print(set1.isEmpty)
print(set1.contains(3))
print(set1.max()!)
print(set1.min()!)


//增删改查
set1.insert(5)
set1.remove(1) //移除某个元素
set1.removeFirst() //移除第一个元素
set1.remove(at: set1.firstIndex(of: 3)!) //移除某个位置的元素
set1.removeAll() //移除所有元素


//集合的数学运算
var set5 = Set([1,2,3,4,5])
var set6 = Set([4,5,6,7,8])

var setInter = set5.intersection(set6)
var setEx = set5.symmetricDifference(set6)
var setUni = set5.union(set6)
var setSub = set5.subtracting(set6)


var set7:Set = [1,2,3]
print(set7.isSubset(of: set5)) //子集
print(set7.isSuperset(of: set5)) ///超集
print(set5.isStrictSubset(of: set7)) //严格子集
print(set7.isStrictSuperset(of: set5)) //严格超集

// 遍历集合
for item in set5 {
    print(item)
}


print("333")
for (index,item) in set5.enumerated() {
    print("index:\(index) item:\(item)")
}

print("2222")
for item in set5.sorted() {
    print(item)
}
print("11111")

for item in set7.indices {
    print(set7[item])
}