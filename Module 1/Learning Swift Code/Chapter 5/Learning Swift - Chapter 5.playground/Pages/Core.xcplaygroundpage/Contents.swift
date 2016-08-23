//: Learning Swift

//: Chapter 5 – A Modern Paradigm: Closures and Functional Programming
//: ============================================================

//: Functional programming philosophy
//: ---------------------------------

//: ### State and side effects

//: A stateless function. This method will always return the same
//: value given the same input
func double(input: Int) -> Int {
    return input * 2
}

struct Ball {
    var radius: Double

    //: A method with state. Calling this multiple times with the same
    //: input will return different output
    mutating func growByAmount(amount: Double) -> Double {
        self.radius = self.radius + amount
        return self.radius
    }

    //: A method with side effects. It is the same method with a name
    //: that doesn't imply it changes state
    mutating func currentRadiusPlusAmount(amount: Double) -> Double {
        self.radius = self.radius + amount
        return self.radius
    }
}

//: ### Declarative v.s. imperative code

//: Imperative code
var originalArray = [1,2,3,4,5]
var greaterThanThree = [Int]()
for num in originalArray {
    if num > 3 {
        greaterThanThree.append(num)
    }
}
print(greaterThanThree) // [4,5]

//: Declaritive code that does the same thing
greaterThanThree = originalArray.filter {$0 > 3}
print(greaterThanThree) // 4,5

//: Closures
//: --------

//: ### Closures as variables

//: Capturing a function in a variable as a closure. Calling a closure
//: looks just like calling a function
var doubleClosure = double
print(doubleClosure(2))

//: Defining a closure inline
//: The "in" keyword separates the parameters from the closure body
var doubleClosure2 = { (input: Double) -> Double in
    return input * 2
}

// Closure with no return value
var printDouble = { (input: Double) -> Void in
    print(input * 2)
}

// Closure with no paretmers
var makeHelloWorld = { () -> String in
    return "Hello World!"
}

//: ### Closures as paramters

//: Function that can find the first number in an array that passes an arbitrary test
//: It that takes a closure that takes an Int and returns a Bool. The outer function
//: then returns an optional Int
func firstInNumbers(numbers: [Int], passingTest: (number: Int) -> Bool) -> Int? {
    for number in numbers {
        if passingTest(number: number) {
            return number
        }
    }
    return nil
}

//: Calling the function with a greaterThanThree closure
let numbers = [1,2,3,4,5]
func greaterThanThree(number: Int) -> Bool {
    return number > 3
}
var firstNumber = firstInNumbers(numbers, passingTest: greaterThanThree)
print(firstNumber) // Optional(4)

//: Defining the closure inline
firstNumber = firstInNumbers(numbers, passingTest: { (number: Int) -> Bool in
    return number > 3
})

//: ### Syntactic Sugar

//: We can leave out the input and return types because they can be infered
//: from the type of closure firstInNumbers is expecting
firstNumber = firstInNumbers(numbers, passingTest: { (number) in
    return number > 3
})

//: If the last parameter to a function is a closure, we can provide it outside
//: of the parenthesis. Also, we can leave out the parenthesis around the input
//: variables
firstNumber = firstInNumbers(numbers) { number in
    return number > 3
}

//: The return keyword is not necessary for a single line closure
firstNumber = firstInNumbers(numbers) { number in
    number > 3
}

//: We don't even have to give a name to parameters. Instead, we can
//: reference them by their index with the $ symbole
firstNumber = firstInNumbers(numbers) { $0 > 3 }

//: My prefered syntax because it keeps it clear what the closure is meant for
firstNumber = firstInNumbers(numbers, passingTest: {$0 > 3})

//: Building blocks of functional programming in Swift
//: --------------------------------------------------

//: ### Filter

//: Filter out the odd elements of an array
//: The passed in closure returns true when we want to include
//: the element in filtered array
var evenNumbers = numbers.filter({ element in
    element % 2 == 0
}) // [2, 4]

//: ### Reduce

//: Calculate the sum of all the elements in numbers
//: The passed in closure takes the previous value return from the closure
//: and the next element and is expected to return the value to be used for
//: the next call. The first call is called with the initial value and the last
//: call returns the final result
var sum = numbers.reduce(0, combine: { previousSum, element in
    previousSum + element
}) // 15

//: The sum of all the even numbers
var evenSum = numbers.filter({$0 % 2 == 0}).reduce(0, combine: {$0 + $1}) // 6
evenSum = numbers.filter({$0 % 2 == 0}).reduce(0, combine: +) // 6

//: Combine all numbers as string
let string = numbers.reduce("", combine: {"\($0)\($1)"}) // "12345"

//: ### Map

//: Map numbers to an array with every number increased by 1
//: The passed in closure takes each element and is expected to return the
//: value it should be mapped to
let plusOne = numbers.map({ element -> Int in
    return element + 1
}) // [2, 3, 4, 5, 6]

//: Create a string version of the numbers array
let strings = numbers.map {String($0)}

//: ### Sorted

//: Sort the numbers from largest to smallest
//: The closure takes two elements and is expected to return weather the first
//: element should be ordered before the second one
numbers.sort({ element1, element2 in
    element1 > element2
}) // [5, 4, 3, 2, 1]

//: Lazy Evaluation
//: ---------------

//: Get the first number as a string
//: The first version converts all numbers to strings while the second only
//: converts the first one
var firstString = numbers.map({String($0)}).first
firstString = numbers.lazy.map({String($0)}).first

//: Loop through a lazily mapped version of numbers to strings
let lazyStrings = numbers.lazy.map(String($0))
for string in lazyStrings {
    print(string)
}

//: Curried functions
//: -----------------

//: A normal function that takes 3 log parameters
func log(component: String, level: String, message: String) {
    print("\(component) - \(level): \(message)")
}

// A curried version of the log function that takes one parameter at a time
func curredLog(component: String) -> (level: String) -> (message: String) -> () {
    func logLevel(level: String) -> (message: String) -> () {
        func logMessage(message: String) -> () {
            print("\(component) - \(level): \(message)")
        }
        return logMessage
    }
    return logLevel
}

//: A full log call
curredLog("main")(level: "debug")(message: "a message")

//: Store a version of the log function that will always have the component "main"
var main = curredLog("main")
main(level: "debug")(message: "a message")

// Store a version of log function that will always have the component "main" and the level "debug"
var mainDebug = main(level: "debug")
mainDebug(message: "another message")

//: A more concise way of defining a curried function
func curredLog2(component: String)(level: String)(message: String) {
    print("\(component) - \(level): \(message)")
}
