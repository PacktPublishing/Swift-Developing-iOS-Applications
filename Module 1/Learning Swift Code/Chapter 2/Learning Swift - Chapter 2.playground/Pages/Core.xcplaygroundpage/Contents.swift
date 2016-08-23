//: Learning Swift

//: Chapter 2 – Building Blocks: Variables, Collections, and Flow Control
//: ======================================================================

//: Constants and Variables
//: ------------------------

//: Constant
let pi = 3.14

//: Variable
var name = "Sarah"

//: Containers
//: -----------

//: ### Tuples

//: Defining
var card = (color: "Red", suit: "Hearts", value: 7)

//: Accessing Values By Name
card.color // "Red"
card.suit // "Hearts"
card.value // 7

//: Accessing Values by Index
var diceRoll = (4, 6)
diceRoll.0 // 4
diceRoll.1 // 6

//: Accessing Values by Assignment
let (first, second) = diceRoll
first // 4
second // 6

//: Updating Value
diceRoll = (4, 5)
diceRoll.0 = 2

//: ### Arrays

//: Defining
var invitees = ["Sarah", "Jamison", "Marcos", "Roana"]

//: Adding Elements
invitees += ["Kai", "Naya"]
invitees = invitees + ["Kai", "Naya"]

//: Accessing Elements by Index
invitees[2] // "Marcos"

//: ### Dictionaries

//: Defining
var showsByGenre = [
    "Comedy": "Modern Family",
    "Drama": "Breaking Bad",
]

//: Accessing Element
showsByGenre["Comedy"] // Modern Family

//: Adding/Updating Element
showsByGenre["Variety"] = "The Colbert Report"


//: Swift's Type System
//: --------------------

//: Strings represent a series of characters
var name_: String = "Sarah"

//: Double represents a decimal number
let pi_: Double = 3.14

//: Array of Strings
var invitees_: [String] = ["Sarah", "Jamison", "Roana"]

//: Dictionary with String Keys and Values
let showsByGenre_: [String:String] = [
    "Comedy": "Modern Family",
    "Drama": "Breaking Bad",
]

//: Printing to the Console
//: ------------------------

print("Hello World!")
print("Hello \(name)!")

//: Control Flow
//: --------------

//: ### Conditionals

//: If the number of invitees is greater than 20 then print "Too many people invited"
if invitees.count > 20 {
    print("Too many people invited")
}

//: If the number of invitees is greater than 20 then print "Too many people invited"
//: otherwise, if the number of invitees is less than or equal to 3 then print "Not really a party
//: otherwise, print "Just right"
if invitees.count > 20 {
    print("Too many people invited")
}
else if invitees.count <= 3 {
    print("Not really a party")
}
else {
    print("Just right")
}

//: ### Switches

//: Considering the number of invitees,
//: in the case that it is greater than 20 print "Too many people invited",
//: otherwise, in the case that it is less than or equal to 3 print "Not really a party",
//: othewise, print "Just right"
switch invitees.count {
    case let x where x > 20:
        print("Too many people invited")
    case let x where x <= 3:
        print("Not really a party")
    default:
        print("Just right")
}

//: Considering the number of invitees,
//: in the case that it is greater than 20 print "Too many people invited",
//: otherwise, in the case that it is less than or equal to 3 print "Not really a party",
//: othewise, do nothing
switch invitees.count {
    case let x where x > 20:
        print("Too many people invited")
    case let x where x <= 3:
        print("Not really a party")
    default:
        break
}

//: Considering the number of invitees,
//: in the case that it is between 0 and 3 print "Not really a party"
//: otherwise, in the case that it is between 4 and 20 print "Just right"
//: othewise, print "Too many people invited"
switch invitees.count {
    case 0...3:
        print("Not really a party")
    case 4...20:
        print("Just right")
    default:
        print("Too many people invited")
}

//: Considering name
//: in the case that it is "Marcos" or "Amy" print "<name> is an honored guest"
//: otherwise, in the case that it starts with "A" print "<name> will be invited first" and print "<name> is someone else"
//: othewise, print "<name> is someone else"
switch name {
    case "Marcos", "Amy":
        print("\(name) is an honored guest")
    case let x where x.hasPrefix("A"):
        print("\(name) will be invited first")
        fallthrough
    default:
        print("\(name) is someone else")
}

//: Considering testName
//: in the case that it is "Marcos" or "Amy" print "<testName> is an honored guest"
//: otherwise, in the case that it starts with "A" print "<testName> will be invited first" and print "<testName> will help arrange food"
//: otherwise, in the case that it is "Jamison" print "<testName> will help arrange food"
//: othewise, print "<testName> is someone else" print
let testName = "Andrew"
switch testName {
    case "Marcos", "Amy":
        print("\(testName) is an honored guest")
    case let x where x.hasPrefix("A"):
        print("\(testName) will be invited first")
        fallthrough
    case "Jamison":
        print("\(testName) will help arrange food")
    default:
        print("\(testName) is someone else")
}

//: ### Loops

//: Print "<invitee> is invited" for every invitee in invitees
var index = 0
while index < invitees.count {
    print("\(invitees[index]) is invited")

    index+=1
}

//: Print "<invitee> is invited" for every invitee in invitees
for var index = 0; index < invitees.count; index++ {
    print("\(invitees[index]) is invited")
}

//: Print "<invitee> is invited" for every invitee in invitees
for invitee in invitees {
    print("\(invitee) is invited")
}

//: Print "<show> is a great <genre>" for every genrea and show pair in showsByGenre
for (genre, show) in showsByGenre {
    print("\(show) is a great \(genre) series")
}

//: Print "<invitee> is invited" for every invitee in invitees that starts with "A"
for invitee in invitees where invitee.hasPrefix("A") {
    print("\(invitee) is invited")
}

//: Print "<invitee> is invited" for every invitee in invitees
for index in 0 ..< invitees.count {
    print("\(index): \(invitees[index])")
}

//: Print every number from 1 to 10
print("Counting to 10:")
for number in 1 ... 10 {
    print(number)
}

//: Print "<invitee> is invited" for every invitee in invitees that does not start with "A"
for invitee in invitees {
    if invitee.hasPrefix("A") {
        continue
    }

    print("\(invitee) is invited")
}

//: Print "<invitee> is invited" for every invitee in invitees until an invitee named "Tim"
for invitee in invitees {
    print("\(invitee) is invited")

    if invitee == "Tim" {
        print("Oh wait, Tim can't come")
        break
    }
}
print("Jumps here")

//: ### Functions

//: print "Hello World!"
func sayHello() {
    print("Hello World!")
}
sayHello()

//: print "Hello <name>"
func sayHelloToName(name: String) {
    print("Hello \(name)!")
}
sayHelloToName("World") // Prints "Hello World!"

//: Add the given invitee to the given invitees array if the number
//: of invitees is less than 20
func addInviteeToListIfSpotAvailable
    (
    invitees: [String],
    newInvitee: String
    )
    -> [String]
{
    if invitees.count >= 20 {
        return invitees
    }
    return invitees + [newInvitee]
}
var list = ["Sarah", "Jamison", "Marcos"]
var newInvitee = "Roana"
list = addInviteeToListIfSpotAvailable(list, newInvitee: newInvitee)

//: Add the given invitee to the given invitees array if the number
//: of invitees is less than 20
func addInvitee
    (
    invitee: String,
    ifPossibleToList invitees: [String]
    )
    -> [String]
{
    if invitees.count >= 20 {
        return invitees
    }
    return invitees + [newInvitee]
}

//: print "Hello <name>"
func sayHelloToName2(name: String = "World") {
    print("Hello \(name)!")
}
sayHelloToName2("World")
sayHelloToName2()

//: Add the given invitee to the given invitees array if the number
//: of invitees is less than 20
func addInvitee2
    (
    invitee: String = "Default Invitee",
    ifPossibleToList invitees: [String] = []
    )
    -> [String]
{
    if invitees.count >= 20 {
        return invitees
    }
    return invitees + [newInvitee]
}

list = addInvitee2(ifPossibleToList: list, newInvitee)
list = addInvitee2(newInvitee, ifPossibleToList: list)
list = addInvitee2(ifPossibleToList: list)
list = addInvitee2()

//: Add the given invitee to the given invitees array if the number
//: of invitees is less than 20
func addInvitee3
    (
    invitee: String,
    ifPossibleToList invitees: [String]
    )
    -> [String]
{
    guard invitees.count < 20 else {
        return invitees
    }
    return invitees + [newInvitee]
}

//: ### Bringing It All Together

import Foundation

//: Repeatedly generate a random number until it equals 3
var inviteesIndex: Int
repeat {
    inviteesIndex = Int(rand()) % 5
} while inviteesIndex != 3


//: [Next](@next)
