//: Learning Swift

import Foundation
srand(UInt32(clock()))

func main() {

//: Chapter 8 – Paths Less Travelled: Error Handling
//: ======================================================================

//: Throwing errors
//: ------------------------

//: ### Defining an error type

struct SimpleError: ErrorType {}

//: ### Impementing a function that throws an error

//: This function will repeat the given string until it is longer than
//: the requested length. It throws an error if the passed in string
//: is empty because then it would be impossible to exceed any length
func repeatString(
    string: String,
    untilLongerThan: Int
    ) throws -> String
{
    guard !string.isEmpty else {
        throw SimpleError()
    }

    var output = string
    while output.characters.count <= untilLongerThan {
        output += string
    }
    return output
}

//: Handling errors
//: ---------------

//: Uncommenting the following will produce an error because the function
//: is defined to be able to throw errors, but we are not calling it in
//: a way that acknowledges that
//let repeated1 = repeatString("Hello", untilLongerThan: 20)
//// Error: Call can throw but is not market with 'try'

//: ### Forecful try

//: This is the unsafe version that will crash your program if an exception is thrown
let repeated2 = try! repeatString("Hello", untilLongerThan: 20)
print(repeated2) // "HelloHelloHelloHello"

//: ### Optional try

//: This option turns the result of the function into an optional instead of risking
//: a crash
let repeated3 = try? repeatString("Hello", untilLongerThan: 20)
print(repeated3) // Optional("HelloHelloHelloHello")

//: If the function already returns an optional, using try? will create an optional
//: of an optional
func aFailableOptional() throws -> String? {
    return "Hello"
}
print(try? aFailableOptional()) // Optional(Optional("Hello"))

//: If the function doesn't return anything, using try? will create an optinal of a
//: void value
func aFailableVoid() throws {
    print("Hello")
}
print(try? aFailableVoid()) // Optional(())

//: ### Catching an error

//: Here we define an enumeration of errors we will want to throw from our function
//: and then we implement the function throwing the errors
enum RandomListError: ErrorType {
    case NegativeListLength
    case FirstNumberMustBeLower
}

func createRandomListContaininingXNumbers(
    xNumbers: Int,
    between low: Int,
    and high: Int
    ) throws -> [Int]
{
    guard xNumbers >= 0 else {
        throw RandomListError.NegativeListLength
    }
    guard low < high else {
        throw RandomListError.FirstNumberMustBeLower
    }

    var output = [Int]()
    for _ in 0 ..< xNumbers {
        let rangeSize = high - low + 1
        let betweenZero = Int(rand()) % rangeSize
        let number = betweenZero + low
        output.append(number)
    }
    return output
}

//: To catch the errors from the function above, we must create an exaustive list
//: of catch blocks. There is no way to specify that the function can only throw our
//: custom error type so we have to provide a default case that just tries to print
//: out the error
do {
    try createRandomListContaininingXNumbers(
        5,
        between: -10,
        and: 10
    )
}
catch RandomListError.NegativeListLength {
    print("Cannot create with a negative number of elements")
}
catch RandomListError.FirstNumberMustBeLower {
    print("First number must be lower than second number")
}
catch let error {
    print("Unknown error: \(error)")
}

//: Instead of using a seperate catch block for each case of the enumeration,
//: we can use a single catch block with a switch in it. This will at least
//: force the compiler to give us an error if an error case is added to the
//: enumeration and we forget to add catching code for it
do {
    try createRandomListContaininingXNumbers(
        5,
        between: 5,
        and: 10
    )
}
catch let error as RandomListError {
    switch error {
    case .NegativeListLength:
        print("Cannot create with a negative number of elements")
    case .FirstNumberMustBeLower:
        print("First number must be lower than second number")
    }
}
catch let error {
    print("Unknown error: \(error)")
}

//: Another option if we only want to print out the error description to the user
//: is to define an error type that has a user readable description property
struct UserError: ErrorType {
    let userReadableDescription: String
    init(_ description: String) {
        self.userReadableDescription = description
    }
}

func createRandomListContaininingXNumbers2(
    xNumbers: Int,
    between low: Int,
    and high: Int
    ) throws -> [Int]
{
    guard xNumbers >= 0 else {
        throw UserError(
            "Cannot create with a negative number of elements"
        )
    }
    
    guard low < high else {
        throw UserError(
            "First number must be lower than second number"
        )
    }

    // ...

    var output = [Int]()
    for _ in 0 ..< xNumbers {
        let rangeSize = high - low + 1
        let betweenZero = Int(rand()) % rangeSize
        let number = betweenZero + low
        output.append(number)
    }
    return output
}

do {
    try createRandomListContaininingXNumbers2(
        5,
        between: 5,
        and: 10
    )
}
catch let error as UserError {
    print(error.userReadableDescription)
}
catch let error {
    print("Unknown error: \(error)")
}

}
main()

//: A more robust solution is a combination of both of these. Define a protocol for erors
//: that can be reported to the user and have our enumeration implement that protocol.
protocol UserErrorType: ErrorType {
    var userReadableDescription: String {get}
}

func main2() {

enum RandomListError: String, UserErrorType {
    case NegativeListLength =
        "Cannot create with a negative number of elements"
    case FirstNumberMustBeLower =
        "First number must be lower than second number"

    var userReadableDescription: String {
        return self.rawValue
    }
}

func createRandomListContaininingXNumbers3(
    xNumbers: Int,
    between low: Int,
    and high: Int
    ) throws -> [Int]
{
    guard xNumbers >= 0 else {
        throw RandomListError.NegativeListLength
    }
    guard low < high else {
        throw RandomListError.FirstNumberMustBeLower
    }

    // ...
    var output = [Int]()
    for _ in 0 ..< xNumbers {
        let rangeSize = high - low + 1
        let betweenZero = Int(rand()) % rangeSize
        let number = betweenZero + low
        output.append(number)
    }
    return output
}

//: Now we can catch a specific case of the enumeration if we have to, otherwise
//: we can fallback to just reporting the error to the user
do {
    try createRandomListContaininingXNumbers3(
        5,
        between: 5,
        and: 10
    )
}
catch RandomListError.NegativeListLength {
    // Do something else
}
catch let error as UserErrorType {
    print(error.userReadableDescription)
}
catch let error {
    print("Unknown error: \(error)")
}

//: ### Propigating errors

//: Since this parent function is marked as possibly throwing errors, we
//: don't have to explicitly handle errors thrown within the implementation.
//: Instead all errors will be propigated up to the caller of the parent
//: function.
func parentFunction() throws {
    try createRandomListContaininingXNumbers3(
        5,
        between: 5,
        and: 10
    )
}

//: Cleaning up in error situations
//: --------------------------------

//: ### Order of execution when errors occur

//: Within a do-catch block, execution will jump to the first matching catch
//: block as soon as the first error is thrown. The whole do block will not
//: be executed unless no errors are thrown
func function1() throws {}
func function2() throws {}
func function3() throws {}

do {
    try function1()
    try function2()
    try function3()
}
catch {
    print("Error")
}

//: However, if we handle errors explcitly within a do block (or a function) it
//: will not cause execution to jump to a ctach block if an error is thrown.
//: Here if function1 throws, it will immediatley crash the program, if function2
//: throws, nothing will happen, and if function3 throws it will jump to the catch
//: block
do {
    try! function1()
    try? function2()
    try function3()
}
catch {
    print("Error")
}

//: ### Defering execution

//: This personal chef type uses a defer block to ensure that it always cleans up
//: regardless of if it fails to complete making crème brûlée
struct PersonalChef {
    func clean() {
        print("Wash dishes")
        print("Clean counters")
    }

    func addIngredients() throws {}
    func bringToBoil() throws {}
    func removeFromHeat() throws {}
    func allowItToSit() throws {}

    func makeCrèmeBrûlée(URL: NSURL) throws {
        defer {
            self.clean()
        }

        try self.addIngredients()
        try self.bringToBoil()
        try self.removeFromHeat()
        try self.allowItToSit()
    }
}

//: Even in non-error scenarios, we can use defer to ensure something happens
//: regardless of the way we exit from the method. Below, we will close the
//: pantry door whether or not we find the ingredient we are looking for
struct Ingredient {
    let name: String
}

struct Pantry {
    private let ingredients: [Ingredient]

    func openDoor() {}
    func closeDoor() {}

    func getIngredientNamed(name: String) -> Ingredient? {
        self.openDoor()

        defer {
            self.closeDoor()
        }

        for ingredient in self.ingredients {
            if ingredient.name == name {
                return ingredient
            }
        }
        return nil
    }
}

//: You can defer as many blocks as you want. They will be called in reverse
//: order from the order they were defered. In this example, "A" will be printed
//: first and "C" will be printed last
func multipleDefers() {
    defer {
        print("C")
    }
    defer {
        print("B")
    }
    defer {
        print("A")
    }
}
multipleDefers()

}
main2()
