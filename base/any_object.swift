// swift Any 和 AnyObject

// AnyObject是通用的引用类型，其并不能用来描述值类型。例如上面的数组不可以存放结构体、枚举等类型的数据。在Swift语言中还提供了一种更加通用的类型Any，它可以用来描述任意类型，包括值类型和引用类型
// ====================AnyObject====================
class MyclassOne {}
class MyclassTwo {}
class MyclassThree {}

var c1 = MyclassOne()
var c2 = MyclassTwo()
var c3 = MyclassThree()
var arr: [AnyObject] = [c1, c2, c3]  //使用anyobject类型的数组

// ====================Any====================
var arr2: [Any] = [1, 2, 3, "str", 1.2, true]  //使用any类型的数组
