//: Learning Swift

//: Chapter 4 – To Be or Not to Be: Optionals
//: ============================================================

//: How to define an optional
//: --------------------------

//: Optional versions of String, Array, and Int
//: Only possibleInt actually has a value while the other two are nil
var possibleString: String?
var possibleArray: [Int]?
var possibleInt: Int? = 10

//: Here we can see how the different types of variables print out. Optionals
//: with values still print out as an optional containing that value, while an
//: optional without a value just prints nil
var actualInt = 10
var nilInt: Int?
print(actualInt) // 10
print(possibleInt) // Optional(10)
print(nilInt) // nil

//: Updating the value of an optional
nilInt = 2
print(nilInt) // Optional(2)

//: Removing the value of an optional
nilInt = nil
print(nilInt) // nil

//: How to unwrap an optional
//: --------------------------

//: ### Optional binding

//: Here we optionally bind the value within possibleString to the
//: temporary constant "string". If it does have a value, the first
//: block of code is run and if it doesn't, the second block is run.
//: In this case, it does not happen to have a value so it prints out
//: "possibleString has no value"
if let string = possibleString {
    print("possibleString has a value: \(string)")
}
else {
    print("possibleString has no value")
}

//: Here we optionaly bind the value to a temporary variable.
//: Importantly, if we change the value of the temporary variable,
//: it does not affect the value of the original optional
possibleInt = 10
if var actualInt = possibleInt {
    actualInt *= 2
    print(actualInt) // 20
}
print(possibleInt) // Optional(10)

//: Here we ensure the original optional is updated by assigning the result
//: of the multiplication to it
if var actualInt = possibleInt {
    actualInt *= 2
    possibleInt = actualInt
}
print(possibleInt) // Optional(20)

//: Optionally binding multiple variables the verbose way
if let actualString = possibleString {
    if let actualArray = possibleArray {
        if let actualInt = possibleInt {
            print(actualString)
            print(actualArray)
            print(actualInt)
        }
    }
}

//: Optionally binding multiple variables the concise way
if let actualString = possibleString,
    let actualArray = possibleArray,
    let actualInt = possibleInt
{
    print(actualString)
    print(actualArray)
    print(actualInt)
}

//: Using a guard statment within a function even eliminates the need
//: to indent our code furhter
func someFunc2() {
    guard let actualString = possibleString,
        let actualArray = possibleArray,
        let actualInt = possibleInt
    else {
        return
    }

    print(actualString)
    print(actualArray)
    print(actualInt)
}

//: ### Forced unwrapping

//: Modifying possibleInt using forced unwrapping (the unsafe version of unwrapping)
possibleInt = 10
possibleInt! *= 2
print(possibleInt) // Optional(20)

//: Force unwrapping an optional that happens to be nil, will crash the entire program
//nilInt! *= 2 // fatal error

//: An appropriate uses of forced unwrapping is when the logic guarantees a value will not be nil,
//: even though it is defined as optional. This example is a lazily calculated value. It has a
//: private property to store the real value that is optional. When other code tries to access
//: the external value it will first make sure that the real contents is not nil. If it is, it loads
//: in the value. At that point, we know for sure it has a value so we force unwrap it to return the
//: non-optional version
class FileSystemItem {}
class File: FileSystemItem {}
class Directory: FileSystemItem {
    private var realContents: [FileSystemItem]?
    var contents: [FileSystemItem] {
        if self.realContents == nil {
            self.realContents = self.loadContents()
        }
        return self.realContents!
    }

    private func loadContents() -> [FileSystemItem] {
        // Do some loading
        return []
    }
}

//: ### Nil coalescing

//: With nil coalescing we can provide a default value in case the optional is nil. Then it will
//: print out as a non-optional
possibleString = "An actual string"
print(possibleString ?? "Default String") // "An actual string"

//: Optional chaining
//: ------------------

//: The verbose version of optionally assigning a new value to an optional
var invitee: String? = "Sarah"
var uppercaseInvitee: String?
if let actualInvitee = invitee {
    uppercaseInvitee = actualInvitee.uppercaseString
}

//: The concise way with optional chaining. It only tries to acess the uppercaseString property
//: if invitee actually contains a value. Otherwise, it immediately returns nil
uppercaseInvitee = invitee?.uppercaseString

//: A longer chain where some elemnents are optional and others are not
//: A ? is only used when the previous method / property returns an optional
var invitees: [String]? = ["Sarah", "Jamison", "Marcos", "Roana"]
invitees?.first?.uppercaseString.hasPrefix("A")

//: If you forget to use a ? when necessary, the compiler will suggest it
//invitees.first // Value of optional type '[String]?' not unwrapped; did you mean to use '1' or '?'?

//: If you use a ? when you shouldn't have, the compiler will tell you
var otherInvitees = ["Kai", "Naya"]
//otherInvitees?.first // Cannot use optional chaining on non-optional value of type '[String]'

//: Optionally calling a method that doesn't actually return anything
invitees?.removeAll()

//: Implicitly unwrapped optionals
//: -------------------------------

//: Implicitly unwrapped optional string
var name: String!

//: Accessing a nil implicitly unwrapped optional crashes the program
//name.uppercaseString // Crash

//: An example of time to use implicitly unwrapped optionals. A UIView does not connect
//: any of its outlets until after initialization but always before awakeFromNib is called.
//: Because of this, we cannot set buttonOriginalWidth during initilization but we can guarentee
//: it will be set in awakeFromNib before any other code tries to use it
import UIKit
class MyView: UIView {
    @IBOutlet var button: UIButton!
    var buttonOriginalWidth: CGFloat!

    override func awakeFromNib() {
        self.buttonOriginalWidth = self.button.frame.size.width
    }
}
