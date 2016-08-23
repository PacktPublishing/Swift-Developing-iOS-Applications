//: Learning Swift

//: Chapter 3 – One Piece at a Time: Types, Scopes, and Projects
//: ============================================================

//: Structs
//: -------

//: ### Types versus instances

//: Here we define a custom type called Contact that has a first and last name
//: It also contains code from later in the chapter
struct Contact {
    var firstName: String = "First"
    var lastName: String = "Last"

    // static constant associated with the type instead of an instance
    static let UnitedStatesPhonePrefix = "+1"

    // method to print full name
    func printFullName() {
        print("\(self.firstName) \(self.lastName)")

        // Using "self" is optional. You can use the property names directly
        print("\(firstName) \(lastName)")
    }

    // static method to print available phone prefixes
    static func printAvailablePhonePrefixes() {
        print(self.UnitedStatesPhonePrefix)

        // Using "self" is optional. You can use the property names directly
        print(UnitedStatesPhonePrefix)
    }

    // method to show specifying a local variable vs a property
    func printFirstName() {
        let firstName = "Fake"
        print("\(self.firstName) \(firstName)") // "First Fake"
    }
}

//: Create an instance of Contact
let someone = Contact()

//: This struct does not provide default values so when initialized, we must
//: give it values
struct Contact2 {
    var firstName: String
    var lastName: String
}

let someone2 = Contact2(firstName: "Sarah", lastName: "Smith")

//: ### Properties

//: Accessing member constants and variables
print("\(someone.firstName) \(someone.lastName)") // "First Last"

//: Accessing static constants and variables
print(Contact.UnitedStatesPhonePrefix) // "+1"

//: Here we define a structure to represent a ball as an object
//: It also contains code from later in the chapter
struct Ball {
    var radius: Double
    var color: String
    var elasticity: Double

    // If you uncomment the following method, it will produce an error because
    // it is trying to mutate the instance when it is not marked as mutable
//    func growByAmount(amount: Double) {
//        // Error: Left side of mutating operator
//        // isn't mutable: 'self' is immutable
//        self.radius += amount
//    }

    // This works because it is marked as mutating
    mutating func growByAmount(amount: Double) {
        self.radius += self.radius
    }

    // Calculated properties
    var diameter: Double {
        get {
            return self.radius * 2
        }
        set {
            self.radius = diameter / 2
        }
    }

    // Read-only computed property. There is no need to specify it as a 'get'
    var volume: Double {
        return self.radius * self.radius * self.radius * 4/3 * 4.13
    }
}

//: If you uncomment this, you will get an error because there are no default values
//: for the various properties
//Ball() // Missing argument for parameter 'radius' in call

//: ### Memeber and static methods

someone.printFullName() // "First Last"

Contact.printAvailablePhonePrefixes() // "+1"

//: ### Computed Properties

var ball = Ball(radius: 2, color: "Red", elasticity: 2)
print(ball.diameter) // 4.0
ball.diameter = 16
print(ball.radius) // 8.0

//: ### Reacting to property changes

//: This ball structure will log the old and new value of its radius property right before
//: and right after it is set.
struct BallLog {
    var radius: Double {
        willSet {
            print("changing from \(self.radius) to \(newValue)")
        }

        didSet {
            print("changed from \(oldValue) to \(self.radius)")
        }
    }
}

//: This structure will cause an infite loop if you try to set the radius or diamter. A change in either
//: will trigger a change in the other, which will in turn trigger another change on the original. This will
//: continue infinitly
struct BallInfinitLoop {
    var radius: Double {
        didSet {
            self.diameter = self.radius * 2
        }
    }

    var diameter: Double {
        didSet {
            self.radius = self.diameter / 2
        }
    }
}

//: ### Subscripts

//: This struct makes use of a custom subscript that lets you assign a movie to someone
//: The return type for the subscript is an optional (as indicated by the ?), we will learn all about these
//: in the next chapter
struct MovieAssignment {
    var movies: [String:String]

    subscript(invitee: String) -> String? {
        get {
            return self.movies[invitee]
        }

        set {
            self.movies[invitee] = newValue
        }
    }

    subscript(param1: String, param2: Int) -> Int {
        return 0
    }
}
var assignment = MovieAssignment(movies: [:])
assignment["Sarah"] = "Modern Family"
print(assignment["Sarah"]) // "Modern Family"
print(assignment["Sarah", 2])

//: ### Custom Initialization

//: This version of the contact class has a custom initializer to create a copy
//: of an existing contact. This custom initializer prevents the default initialier from
//: being provided so we must also give our own initializer that takes a first name and
//: last name.
struct Contact3 {
    var firstName: String
    var lastName: String

    init(contact: Contact3) {
        self.firstName = contact.firstName
        self.lastName = contact.lastName
    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Contact4 {
    var firstName: String
    var lastName: String

    // Uncommenting the following will produce an error:
    // Return from initializer without initializing all stored properties
//    init(firstName: String) {
//        self.firstName = firstName
//    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    func print() {}

    // Uncommenting the following will produce an error:
//    init(contact: Contact4) {
//        self.print() // Use of 'self' in delegating initializer before self.init is called
//        self.init(
//            firstName: contact.firstName,
//            lastName: contact.lastName
//        )
//    }

    init(contact: Contact4) {
        self.init(
            firstName: contact.firstName,
            lastName: contact.lastName
        )
        self.print()
    }
}

var sarah = Contact3(firstName: "Sarah", lastName: "Smith")
var sarahCopy = Contact3(contact: sarah)
var other = Contact3(firstName: sarah.firstName, lastName: sarah.lastName)

//: Classes
//: -------

//: ### Inheriting from another class

//: A class that represents a building with a given square footage
class Building {
    let squareFootage: Int

    // Required Initializer - must be overriden by all subclasses
    required init(squareFootage: Int) {
        self.squareFootage = squareFootage
    }

    // Convenience initializer
    // It must call a designated initializer to ensure every
    // property is initialized
    convenience init(otherBuilding: Building) {
        self.init(squareFootage: otherBuilding.squareFootage)
    }

    func clean() {
        print(
            "Scrub \(self.squareFootage) squre feet of floors"
        )
    }

    var estimatedEnergyCost: Int {
        return squareFootage / 10
    }
}
var aBuilding = Building(squareFootage: 1000)

//: A subclass of building that also stores the number of bedrooms and bathrooms
class House: Building {
    let numberOfBedrooms: Int
    let numberOfBathrooms: Double

    init(
        squareFootage: Int,
        numberOfBedrooms: Int,
        numberOfBathrooms: Double
        )
    {
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms

        super.init(squareFootage: squareFootage)
    }

    // Overriding initializer fullfilling the required initializer requirement
    required init(squareFootage: Int) {
        self.numberOfBedrooms = 0
        self.numberOfBathrooms = 0
        super.init(squareFootage: squareFootage)
    }

    // Uncommenting the following will produce an error:
    // Must call a designated initializer of the superclass 'Building'
//    init() {
//        self.numberOfBedrooms = 0
//        self.numberOfBathrooms = 0
//        let building = Building(squareFootage: 0)
//        super.init(otherBuilding: building)
//    }

    // Overriding method that calls the superclass' version of the method
    override func clean() {
        super.clean()

        print("Make \(self.numberOfBedrooms) beds")
        print("Clean \(self.numberOfBathrooms) bathrooms")
    }

    // Overriding computed property that adds 100 to the superclass' version
    override var estimatedEnergyCost: Int {
        return 100 + super.estimatedEnergyCost
    }
}

var aHouse = House(
    squareFootage: 800,
    numberOfBedrooms: 2,
    numberOfBathrooms: 1
)
print(aHouse.squareFootage)
print(aHouse.numberOfBedrooms)

//: ### Designated and Convenience Initializers

var defaultBuilding = Building(otherBuilding: aBuilding)

//: Casting
//: -------

//: We can pass an array of both buildings and houses to this function
func totalSquareFootageOfBuildings(buildings: [Building]) -> Int {
    var sum = 0
    for building in buildings {
        sum += building.squareFootage
    }
    return sum
}

var buildings = [
    House(squareFootage: 1000),
    Building(squareFootage: 1200),
    House(squareFootage: 900)
]
print(totalSquareFootageOfBuildings(buildings)) // 3100

//: Here we can cast a House instance to a Building
var someBuilding: Building = House(squareFootage: 1000)

//: ### Upcasting

//: This is another way of casting a House instance to a Building
//: It is considered upcasting because we are going from a class
//: to a super class
var someBuilding2 = House(squareFootage: 1000) as Building

//: ### Downcasting

//: Forcefully downcasting a Building to a House
var house = someBuilding as! House
print(house.numberOfBathrooms)

//: Uncommenting the following will produce a crash because
//: aBuilding is not a House
// var anotherHouse = aBuilding as! House

//: Here, we can cast someBuilding to a House only if it is
//: actually a house. If the casting is successful, we can use
//: the `house` variable as a House type
if let house = someBuilding as? House {
    // someBuilding is of type House
    print(house.numberOfBathrooms)
}
else {
    print("somebuilding is not a house")
}

//: Enumerations
//: -------------

//: Enumeration that represents the possible primary colors
enum PrimaryColor {
    case Red
    case Green
    case Blue
}

var color = PrimaryColor.Green
color = .Red

//: ### Testing enumeration values

//: It is possible to test an enumeration with if statements
if color == PrimaryColor.Red {
}
else if color == .Blue {
}

//: But it is better to use a switch because it is more expressive
//: and requires that we handle every case for safety
switch color {
    case .Red:
        print("color is red")
    case .Green:
        print("color is green")
    case .Blue:
        print("color is blue")
}

//: ### Raw values

//: Enumeration that represents the different US currency coins
//: with their raw value
enum USCoins: Int {
    case Quarter = 25
    case Dime = 10
    case Nickel = 5
    case Penny = 1
}

print("A Quarter is worth \(USCoins.Quarter.rawValue) cents.")

//: ### Associated values

//: Enumeration to represent a height measurement in different
//: units using associated values
enum Height {
    case Imperial(feet: Int, inches: Double)
    case Metric(meters: Double)
    case Other(String)
}
var height1 = Height.Imperial(feet: 6, inches: 2)
var height2 = Height.Metric(meters: 1.72)
var height3 = Height.Other("1.9 x 10-16 light years")

//: Testing a Height enumeration value and acessing the associated values
switch height1 {
    case .Imperial(let feet, var inches):
        print("\(feet)ft \(inches)in")
    case let .Metric(meters):
        print("\(meters) meters")
    case var .Other(text):
        print(text)
}

//: Extra conditions for cases using a where clause
switch height1 {
    case .Imperial(let feet, var inches) where feet > 1:
        print("\(feet)ft \(inches)in")
    case let .Metric(meters) where meters > 0.3:
        print("\(meters) meters")
    case var .Other(text):
        print(text)
    default:
        print("Too Small")
}
//: Ignoring associated values
switch height1 {
    case .Imperial(_, _):
        print("Imperial")
    case .Metric(_):
        print("Metric")
    case .Other (_):
        print("Other")
}

//: ### Methods and properties

//: Enumeration to represent a distance with a function to convert to meters
enum Distance {
    case Imperial(feet: Int, inches: Double)
    case Metric(meters: Double)

    func meters() -> Double {
        switch self {
            case let .Imperial(feet, inches):
                return Double(feet)*0.3048+inches*0.3048/12
            case let .Metric(meters):
                return meters
        }
    }
}
var distance1 = Distance.Imperial(feet: 6, inches: 2)
distance1.meters() // 1.8796

//: ### File Organization and Navigation

//: Extensions
//: ----------

//: Extension to Building that adds a calculated property and a function
extension Building {
    var report: String {
        return "This building is \(self.squareFootage) square feet"
    }

    func isLargerThanOtherBuilding(building: Building) -> Bool {
        return self.squareFootage > building.squareFootage
    }
}

//: Extension to string that allow repeating the string N times
extension String {
    func repeatNTimes(nTimes: Int) -> String {
        var output = ""
        for _ in 0..<nTimes {
            output += self
        }
        return output
    }
}
"-".repeatNTimes(4) // ----

//: Scope
//: ------

//: ### How is scope defined

var outer = "Hello"
if outer == "Hello" {
    var inner = "World"
    // Both outer and inner are in scope
    print(outer)
    print(inner)
}
// Now only outer is in scope because inner was defined inside the
// curly brackets above
print(outer)
//print(inner) // Error: Use of unresolved identifier 'inner'

//: ### Nested types

//: Defining a struct within a class. The struct is only accessible from
//: inside the class or through the class
class Outerclass {
    struct InnerStruct {
    }
}
let inner = Outerclass.InnerStruct()


//: Access Control
//: --------------

//: All of the following are marked as private so they would not be accessible from
//: any other file
private var mySecretString = "Hello World"
private struct MyPrivateStruct {
    private var privateProperty: String
    private func privateMethod() {
    }
}
