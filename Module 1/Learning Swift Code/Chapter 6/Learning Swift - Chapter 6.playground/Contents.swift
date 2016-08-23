//: Learning Swift

//: Chapter 6 – Make Swift Work For You: Protocols and Generics
//: ============================================================

//: Protocols
//: ---------------------------------

//: ### Defining a protocol

//: Define a protocol for a container that holds strings
//: It has a read-only count property for the number of elements,
//: a mutating method to add a string, and a method to enumerate
//: the strings currently in the container.
protocol StringContainer {
    var count: Int {get}
    mutating func addString(string: String)
    func enumerateStrings(handler: (string: String) -> Void)
}

//: ### Implementing a protocol

//: Uncommenting the following produces this error:
//: "Type 'StringBag' does not conform to protocol 'StringContainer'"
//: because it claims to implement the protocol but does not fullfill all of
//: the requirements
//struct StringBag: StringContainer {
//}

//: This version of StringBag does fullfill all of the requirements
struct StringBag: StringContainer {
    var strings = [String]()

    var count: Int {
        return self.strings.count
    }

    mutating func addString(string: String) {
        self.strings.append(string)
    }

    func enumerateStrings(handler: (string: String) -> Void) {
        for string in self.strings {
            handler(string: string)
        }
    }
}

//: This version of StringBag2 is a class and also implements the full
//: string container protocol. Notice that you can inherit from only one
//: superclass but you can implement as many protocols as you want
class SomeSuperclass {}
class StringBag2: SomeSuperclass, StringContainer {
    var strings = [String:Void]()
    var count: Int {
        return self.strings.count
    }

    func addString(string: String) {
        self.strings[string] = ()
    }

    func enumerateStrings(handler: (string: String) -> Void) {
        for string in self.strings.keys {
            handler(string: string)
        }
    }
}

//: Here we have a variable defined with the type of the protocol so
//: we can assign it to any instance of any type that implements the protocol
var someStringBag: StringContainer = StringBag()
someStringBag.addString("Sarah")
someStringBag = StringBag2()
someStringBag.addString("Sarah")

//: ### Using type aliases

//: Here we use a type alias to define a protocol for a container of that holds any type
protocol Container {
    typealias Element

    var count: Int {get}
    mutating func addElement(element: Element)
    func enumerateElements(handler: (element: Element) -> Void)
}

//: Implement the container protocol with the element type being String
struct StringBag3: Container {
    typealias Element = String

    var elements = [Element:Void]()

    var count: Int {
        return elements.count
    }

    mutating func addElement(element: Element) {
        self.elements[element] = ()
    }

    func enumerateElements(handler: (element: Element) -> Void) {
        for element in self.elements.keys {
            handler(element: element)
        }
    }
}

//: Implement the container protocol with the element type being Int
struct IntBag: Container {
    typealias Element = Int

    var elements = [Element:Void]()

    var count: Int {
        return elements.count
    }

    mutating func addElement(element: Element) {
        self.elements[element] = ()
    }

    func enumerateElements(handler: (element: Element) -> Void) {
        for element in self.elements.keys {
            handler(element: element)
        }
    }
}

//: Generics
//: ---------

//: ### Generic Function

//: A function that can find the first object in any array that passes
//: a gtiven test. The type of closure this function requires will depend on
//: the type of elements in the array one passes into it
func firstInArray<ValueType>(
    array: [ValueType],
    passingTest: (value: ValueType) -> Bool
    ) -> ValueType?
{
    for value in array {
        if passingTest(value: value) {
            return value
        }
    }
    return nil
}

let strings = ["This", "is", "a", "sentence"]
let numbers = [1, 1, 2, 3, 5, 8, 13]
firstInArray(strings, passingTest: {$0 == "a"}) // "a"
firstInArray(numbers, passingTest: {$0 > 10}) // 13

//: This produces an error because the type of array does not match the closure
//firstInArray(numbers, passingTest: {$0 == "a"})
// Cannot convert value of type '[Int]' to expected argument type'[_]'

//: ### Generic Type

//: A generic version of the Bags above. It can hold any type of value
struct Bag<ElementType> {
    var elements = [ElementType]()

    mutating func addElement(element: ElementType) {
        self.elements.append(element)
    }

    func enumerateElements(
        handler: (element: ElementType) -> ()
        )
    {
        for element in self.elements {
            handler(element: element)
        }
    }
}

//: The exact type of the generic is determine when the instance is created
var stringBag = Bag(elements: ["This", "is", "a", "sentence"])
var numberBag = Bag(elements: [1, 1, 2, 3, 5, 8, 13])


//: Here we get an error because the type of the generic can't be determined
//: From the initial value
//var emptyBag = Bag(elements: []) // Cannot invoke initilaizer for
// type 'Bag<_>' with an argument list of type '(elements: [_])'

//: We can get around it by giving an explicit type to it
var emptyBag: Bag<String> = Bag(elements: [])

//: ### Protocol Constriants

//: A generic function that can only operate on arrays with elements that can be
//: compared with the == operator (as enforced by the Equatable constraint)
func indexOfValue<T: Equatable>(
    value: T,
    inArray array: [T]
    ) -> Int?
{
    var index = 0
    for testValue in array {
        if testValue == value {
            return index
        }
        index++
    }
    return nil
}

//: Uncommenting the following will create an error because MyType does not implement
//: the Equatable protocol
//class MyType {}
//var typeList = [MyType]()
//indexOfValue(MyType(), inArray: typeList)
// Cannot convert value of type '[MyType]' to expected argument type '[_]'

//: Uncommenting the following will create an error because ElementType is not guarenteed
//: to work as a dictionary key
//struct Bag2<ElementType> {
//    var elements: [ElementType:Void]
//    // Type 'ElementType' does not conform to protocol 'Hashable'
//}

//: This version of Bag2 works because we require that its element always implement the
//: Hashable protocol that its internal dictionary requires
struct Bag2<ElementType: Hashable> {
    var elements: [ElementType:Void]

    mutating func addElement(element: ElementType) {
        self.elements[element] = ()
    }

    func enumerateElements(
        handler: (element: ElementType) -> ()
        )
    {
        for element in self.elements.keys {
            handler(element: element)
        }
    }
}

//: ### Where clauses for protocols

//: Define a function that can only be used with containers
//: that hold equatable elements
func container<C: Container where C.Element: Equatable>(
    container: C,
    hasElement element: C.Element
    ) -> Bool
{
    var hasElement = false
    container.enumerateElements { testElement in
        if element == testElement {
            hasElement = true
        }
    }
    return hasElement
}

//: ### Where clauses for equality

//: Merge two containers together as long as they contain the same type of
//: value
func merged<C1: Container, C2: Container where C1.Element == C2.Element>(
    lhs: C1,
    rhs: C2
    ) -> C1
{
    var merged = lhs
    rhs.enumerateElements { element in
        merged.addElement(element)
    }
    return merged
}

//: Extending existing generics

//: You should not and cannot try to redeclare the placeholder type of an existing generic
//extension Array<Element> { // Use of undeclared type 'Element'
//    // ...
//}

//: This method actually declares a new placeholder called 'Element'
//: that obscures the real placeholder type for the array
extension Array {
    func someMethod<Element>(element: Element) {
        // ...
    }
}

//: Uncommenting this will create an error because the Element placeholder declared
//: in the method is actually not the same type as the Element placeholder for the array
//extension Array {
//    mutating func addElement<Element>(element: Element) {
//        self.append(element)
//        // Cannot invoke 'append' with argument list
//        // of type '(Element)'
//    }
//}

//: Add a method to all arrays to test if it contains an element that passes
//: a given test
extension Array {
    func hasElementThatPasses(
        test: (element: Element) -> Bool
        ) -> Bool
    {
        for element in self {
            if test(element: element) {
                return true
            }
        }
        return false
    }
}

//: Add a method to all arrays that contain equatble elements to test if
//: it contains a given element
extension Array where Element: Equatable {
    func containsElement(element: Element) -> Bool {
        for testElement in self {
            if testElement == element {
                return true
            }
        }
        return false
    }
}

[1,2,3,4,5].containsElement(4) // true
//class MyType {}
//var typeList = [MyType]()
//typeList.containsElement(MyType()) // Type 'MyType' does not
// conform to protocol 'Equtable'

//: ### Extending protocols

//: A method to check if a comparable value is between two other values
extension Comparable {
    func isBetween(a: Self, b: Self) -> Bool {
        return a < self && self < b
    }
}

6.isBetween(4, b: 7) // true
"A".isBetween("B", b: "Z") // false

protocol Building {
    var squareFootage: Int {get}
}

extension Building {
    func clean() {
        print(
            "Scrub \(self.squareFootage) square feet of floors"
        )
    }
}

struct House: Building {
    let squareFootage: Int
    let numberOfBedrooms: Int
    let numberOfBathrooms: Double

    func clean() {
        print("Make \(self.numberOfBedrooms) beds")
        print("Clean \(self.numberOfBathrooms) bathrooms")
    }
}

struct Factory: Building {
    let squareFootage: Int
}

let house = House(
    squareFootage: 1000,
    numberOfBedrooms: 2,
    numberOfBathrooms: 1.5
)
house.clean()
// Make 2 beds
// Clean 1.5 bathrooms

(house as Building).clean()
// Scrub 1000 square feet of floors

//: Putting protocols and generics to use
//: --------------------------------------

//: ### Generators

//: Define a generator that can produce the infinit series called
//: a Fibonacci sequence
struct FibonacciGenerator: GeneratorType {
    typealias Element = Int

    var values = (0, 1)

    mutating func next() -> Element? {
        self.values = (
            self.values.1,
            self.values.0 + self.values.1
        )
        return self.values.0
    }
}

//: Now we can interate through that sequence as many times as we want
//: by asking for each element using the 'next' method
print("Fibinacci Sequence using generator:")
var generator = FibonacciGenerator()
while let next = generator.next() {
    if next > 10 {
        break
    }
    print(next)
} // 1, 1, 2, 3, 5, 8

//: ### Sequences

//: A SequenceType wrapper for our Fibonacci generator so that we can
//: iterate through it more cleanly
struct FibonacciSequence: SequenceType {
    typealias Generator = FibonacciGenerator

    func generate() -> Generator {
        return FibonacciGenerator()
    }
}

//: Now we can use a normal for loop to go through it
print("Fibinacci Sequence using sequence:")
for next in FibonacciSequence() {
    if next > 10 {
        break
    }
    print(next)
} // 1, 1, 2, 3, 5, 8

//: This version of a Fibonacci sequence does not requre
//: that we define a custom Generator type. Instead it uses an AnyGenerator
struct FibonacciSequence2: SequenceType {
    typealias Generator = AnyGenerator<Int>

    func generate() -> Generator {
        var values = (0, 1)
        return anyGenerator({
            values = (values.1, values.0 + values.1)
            return values.0
        })
    }
}

print("Fibinacci Sequence using only sequence:")
for next in FibonacciSequence2() {
    if next > 10 {
        break
    }
    print(next)
} // 1, 1, 2, 3, 5, 8

//: This sequence allows us to limit another sequence to below a certain maximum
struct SequenceLimiter<
    S: SequenceType where S.Generator.Element: Comparable
    >: SequenceType
{
    typealias Generator = AnyGenerator<S.Generator.Element>
    let sequence: S
    let max: S.Generator.Element

    init(_ sequence: S, max: S.Generator.Element) {
        self.sequence = sequence
        self.max = max
    }

    func generate() -> Generator {
        var g = self.sequence.generate()
        return anyGenerator({
            if let next = g.next() {
                if next <= self.max {
                    return next
                }
            }
            return nil
        })
    }
}

//: This is a helper to allow us to create a SequenceLimiter more easily
//: and concisely
extension SequenceType where Generator.Element: Comparable {
    func limit(max: Generator.Element) -> SequenceLimiter<Self> {
        return SequenceLimiter(self, max: max)
    }
}

//: This extension allows us to concisely find the product of a sequence of
//: integers
extension SequenceType where Generator.Element == Int {
    var product: Generator.Element {
        return self.reduce(1, combine: *)
    }
}

//: Product of Fibonacci numbers under 50
FibonacciSequence().limit(50).product // 2,227,680

