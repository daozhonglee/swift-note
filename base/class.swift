//swift 类与结构体

class Car {
    var brand: String
    var price: Double
    var color: String
    var type: String
    var speed: Int

    init(brand: String, price: Double, color: String, type: String, speed: Int) {
        self.brand = brand
        self.price = price
        self.color = color
        self.type = type
        self.speed = speed
    }

    func drive() {
        print("drive")
    }

    func speedUp() {
        print("speed up")
    }

    func speedDown() {
        print("speed down")
    }
}

var car = Car(brand: "BMW", price: 1_000_000, color: "black", type: "X6", speed: 200)
var car2 = car
//类是引用类型，对类实例进行数据传递时并不会产生复制行为
car2.price = 100

print(car.price)
print(car2.price)

//类的继承
//在Swift语言中，不继承任何类的类被称为基类，继承而来的类被称为子类，其所继承的类被称为父类
//Swift语言中还提供了一个final关键字，final关键字用于修饰某些终极的属性、方法或者类。被final修饰的属性和方法不能够被子类覆写,如果不希望某个类被继承，也可以使用final关键字来修饰这个类，使其成为终极类
//

class Transportation {
    var petrol: Int = 10
    final var type: Int = 0  //不能被继承
    func drive() {
        if petrol == 0 {
            self.addPetrol()
        }
    }
    func addPetrol() {
        self.petrol += 1
    }

}
class Car2: Transportation {
    var tyre: Int
    override func drive() {
        super.drive()
        print("car drive")
        self.petrol -= 1
    }
    init(tyreCount: Int) {
        self.tyre = tyreCount
    }
}

class Boat: Transportation {
    var floor: Int
    override func drive() {
        super.drive()
        print("boat drive")
        self.petrol -= 1
    }
    init(floorCount: Int) {
        self.floor = floorCount
    }
}

class AirPlane: Transportation {
    var height: Int
    override func drive() {
        super.drive()
        print("airplane drive")
        self.petrol -= 1
    }
    init(heightCount: Int) {
        self.height = heightCount
    }
}

var car5 = Car2(tyreCount: 4)
var boat = Boat(floorCount: 5)
var airplane = AirPlane(heightCount: 6)

car5.drive()
boat.drive()
airplane.drive()

// 读者需要注意，如果要对值类型进行比较操作，应使用等于运算符“==”​；对引用类型进行比较操作，应使用等同运算符“===
class TextClass {}
var t1 = TextClass()
var t2: TextClass = TextClass()
print(t1 === t2)/// false
