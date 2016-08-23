//: Learning Swift

//: Chapter 7 – Everything is Connected: Memory Management
//: ======================================================================

//: Value types versus reference types
//: ---------------------------------

//: ### Behviour on assignment

//: Value types are always copied on assignemnt
//: Changing the original value does not affect the copy
var value1 = "Hello"
var value2 = value1
value1 += " World!"
print(value1) // "Hello World!"
print(value2) // "Hello"

//: Reference types are shared on assignment
//: Changing the orignal value also affects the copy
class Person {
    var name: String

    init(name: String) {
        self.name = name
    }
}
var reference1 = Person(name: "Kai")
var reference2 = reference1
reference1.name = "Naya"
print(reference1.name) // "Naya"
print(reference2.name) // "Naya"

//: Howerver, reassigning a reference type, does not affect
//: the original value
reference2 = Person(name: "Kai")
print(reference1.name) // "Naya"
print(reference2.name) // "Kai"

//: ### Behavior on input

//: This is a function takes a modifies both a referenc type (person)
//: and a value type (name). The original reference type  is modified
//: while the original value type is not
func setNameOfPerson(person: Person, var to name: String) {
    person.name = name
    name = "Other Name"
}

var person = Person(name: "Sarah")
var newName = "Jamison"
setNameOfPerson(person, to: newName)

print(person.name) // "Jamison"
print(newName) // "Jamison"

//: Inout value type parameters are treated like references to value types so when
//: we change the value it also changes the original one
func updateString(inout string: String) {
    string = "Other String"
}

var someString = "Some String"
updateString(&someString)
print(someString)

//: Inout reference type parameters are treated like references to a reference so
//: when we alter the vlaue, it alters all instances the original reference was
//: pointing to, but if we change where it is refering to, it changes where the passed
//: in variable is refering to
func updatePerson(inout insidePerson: Person) {
    insidePerson.name = "New Name"
    insidePerson = Person(name: "New Person")
}

var person2 = person
updatePerson(&person)
print(person.name) // "New Person"
print(person2.name) // "New Name"

//: ### Closure capture behavior

//: This closure captures the variable nameToPrint even though it is not passed in explicitly
var nameToPrint = "Kai"
var printName = {
    print(nameToPrint)
}
printName() // "Kai"

//: Captured variables are treated simiarly to inout paramets. If you change a captured
//: value type, the original value is changed as well
var outsideName = "Kay"
var setName = {
    outsideName = "New Name"
}
print(outsideName) // "Kai"
setName()
print(outsideName) // "New Name"

//: When a reference value is captured, changes will be applied to original value as wel
var outsidePerson = Person(name: "Kai")
var setPersonName = {
    outsidePerson.name = "New Name"
}
print(outsidePerson.name) // "Kai"
setPersonName()
print(outsidePerson.name) // "New Name"

//: We can take advantage of the inout nature of closure captures to use the printName
//: closure to print any name we assign to the nameToPrint variable it captured
nameToPrint = "Kai"
printName() // "Kai"
nameToPrint = "New Name"
printName() // "New Name"

//: Using a capture list, we can revert to the default assignment behavior
//: Even after we change nameToPrint, printNameWithCapture still prints the original
//: value it captured
nameToPrint = "Original Name"
var printNameWithCapture = { [nameToPrint] in
    print(nameToPrint)
}
printNameWithCapture() // "Original Name"
nameToPrint = "New Name"
printNameWithCapture() // "Original Name"

//: Automatic reference counting
//: ----------------------------

//: Here, the variable something is created when the function is called and deleted
//: right after the function finishes becuase it is no longer in scope
func printSomething() {
    let something = "Hello World!"
    print(something)
}

//: ### Object relationships

//: Here, Car has a strong relationship to a SteeringWheel through the
//: property 'steeringWheel' as it is the default type of relationship
class SteeringWheel {}
class Car {
    var steeringWheel: SteeringWheel

    init(steeringWheel: SteeringWheel) {
        self.steeringWheel = steeringWheel
    }
}

let wheel = SteeringWheel()
let car = Car(steeringWheel: wheel)

//: Here, Car2 still has a strong relationship to SteeringWheel2, but SteeringWheel2 also
//: has a weak reference back to the Car2 that it is in. If the Car2 is deleted before the
//: SteeringWheel2, the car property will be set to nil
class SteeringWheel2 {
    weak var car: Car2?
}
class Car2 {
    var steeringWheel: SteeringWheel2

    init(steeringWheel: SteeringWheel2) {
        self.steeringWheel = steeringWheel
        self.steeringWheel.car = self
    }
}

//: Strong reference cycles
//: ------------------------

//: ### Between objects

//: Here we have a strong reference cycle between Car3 and SteeringWheel3
class SteeringWheel3 {
    var car: Car3?
}
class Car3 {
    var steeringWheel: SteeringWheel3

    init(steeringWheel: SteeringWheel3) {
        self.steeringWheel = steeringWheel
        self.steeringWheel.car = self
    }
}

//: Here we have a three-way strong reference cylce between Manufacturer4, SteeringWheel4,
//: and Car4

class Manufaturer4 {
    var cards: [Car4] = []
}
class SteeringWheel4 {
    var manufacturer: Manufaturer4?
}
class Car4 {
    var steeringWheel: SteeringWheel4?
}

//: To fix the cycles, we can change one of the relationships to a weak one
class SteeringWheel5 {
    weak var car: Car5?
}
class Car5 {
    var steeringWheel: SteeringWheel5

    init(steeringWheel: SteeringWheel5) {
        self.steeringWheel = steeringWheel
        self.steeringWheel.car = self
    }
}

//: We can also fix it by making one of the relationships unowned but we should only do so
//: if we can guaranetee neither will be deleted without the other
class SteeringWheel6 {
    unowned var car: Car6

    init(car: Car6) {
        self.car = car
    }
}
class Car6 {
    var steeringWheel: SteeringWheel6!

    init() {
        self.steeringWheel = SteeringWheel6(car: self)
    }
}

//: ### With closures

//: This ball class has a callback that will be called every time the ball bounces
class Ball {
    var location: (x: Double, y: Double) = (0,0)
    var onBounce: (() -> ())?
}

//: Here we are creating a strong reference cycle between the ball and its callback
//: because we captured a reference tot he ball inside the closure we assigned to it
let ball = Ball()
ball.onBounce = {
    print("\(ball.location.x), \(ball.location.y)")
}

//: We can break this cycle by capturing the ball inside the closure weakly using a
//: capture list
ball.onBounce = { [weak ball] in
    print("\(ball?.location.x), \(ball?.location.y)")
}

//: However, it is better to use unowned becuase that will eliminate the need to use
//: optional chaining and it is afe because the closure will not be called after the
//: instance is deleted
ball.onBounce = { [unowned ball] in
    print("\(ball.location.x), \(ball.location.y)")
}

//: Lost objects
//: -------------

//: ### Between objects

//: Here neither SteeringWheel7 nor Car7 will ensure the other is deleted because
//: both are refering to each other weakly
class SteeringWheel7 {
    weak var car: Car7?
}
class Car7 {
    weak var steeringWheel: SteeringWheel7!

    init(steeringWheel: SteeringWheel7) {
        self.steeringWheel = steeringWheel
        steeringWheel.car = self
    }
}

//: When wheel7 goes out of scope, it will be deleted which will reset the steeringWheel
//: property of car7 to nil
let wheel7 = SteeringWheel7()
let car7 = Car7(steeringWheel: wheel7)

//: ### With closures

//: This is not possible because you can't make a reference to a closure weak
//class Ball2 {
//    weak var onBounce: (() -> ())?
//    // Error: 'weak cannot be applied to non-class type '() -> ()'
//}
