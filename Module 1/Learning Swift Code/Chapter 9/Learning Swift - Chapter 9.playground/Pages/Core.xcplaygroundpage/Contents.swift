//: Learning Swift


//: Chapter 9 – Writing Code the Swift Way: Design Patterns and Techniques
//: ======================================================================

//: Behavioral Patterns
//: ------------------------

//: ### Iterator

//: This example is from chapter 6 and shows us the use of an interator using
//: the GeneratorType protocol. We can iterate through any list that implements
//: the GeneratorType protocol without caring or knowing how the list is actually
//: implemented.
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

//: ### Observer

//: To make an observable action on an object, you can use a closure property.
//: Here, another object can assign a closure to the onCashWithdrawn property that
//: will be called every time cash is withdrawn
class ATM {
    var onCashWithdrawn: ((amount: Double) -> ())?

    func withdrawCash(amount: Double) {
        // other work

        // Notify observer if any
        if let callback = self.onCashWithdrawn {
            callback(amount: amount)
        }
    }
}

//: The record keeper type below can be setup to observe an ATM and track
//: every transaction
class RecordKeeper {
    var transactions = [Double]()

    func watchATM(atm: ATM) {
        atm.onCashWithdrawn = { [weak self] amount in
            self?.transactions.append(amount)
        }
    }
}

//: This notification center allows more than one object to observer the same
//: event.
class ATMWithrawalNotifictionCenter {
    typealias Callback = (amount: Double) -> ()
    private var observers: [String:Callback] = [:]

    func trigger(amount: Double) {
        for (_, callback) in self.observers {
            callback(amount: amount)
        }
    }

    func addObserverForKey(key: String, callback: Callback) {
        self.observers[key] = callback
    }

    func removeObserverForKey(key: String) {
        self.observers[key] = nil
    }
}

//: Structural Patterns
//: --------------------

//: ### Composite

//: This class contains an array of additional instances of the same class. This
//: allows us to create a theoretically infinite hierarchy of views that can be
//: used to represent what is drawn on a computer screen.
class View {
    var color: (red: Float, green: Float, blue: Float)
        = (1, 1, 1) // white
    var position: (x: Float, y: Float) = (0, 0)
    var size: (width: Float, height: Float)
    var subviews = [View]()

    init(size: (width: Float, height: Float)) {
        self.size = size
    }
}

//: The following code sets up a view heiarchy with a red on the left half, green
//: on the upper right half, and blue on the lower right half
let rootView = View(size: (width: 100, height: 100))
let leftView = View(size: (
    width: rootView.size.width / 2,
    height: rootView.size.height
))
leftView.color = (red: 1, green: 0, blue: 0)
rootView.subviews.append(leftView)

let rightView = View(size: (
    width: rootView.size.width / 2,
    height: rootView.size.height
))
rightView.color = (red: 0, green: 0, blue: 1)
rightView.position = (x: rootView.size.width / 2, y:0)
rootView.subviews.append(rightView)

let upperRightView = View(size: (
    width: rightView.size.width,
    height: rootView.size.height / 2
))
upperRightView.color = (red: 0, green: 1, blue: 0)
rightView.subviews.append(upperRightView)

//: The composite pattern can be used as an alternative to subclassing. Instead
//: of defining a Sentence type as a subclass of a string, we can simply have our
//: Sentence type contain a string
struct Sentence {
    var words: [String]

    enum Type: String {
        case Statement = "."
        case Question = "?"
        case Exclamation = "!"
    }

    var type: Type

    var string: String {
        return self.words.joinWithSeparator(" ")
            + self.type.rawValue
    }
}

let sentence = Sentence(words: [
    "This", "is",
    "a", "sentence"
], type: .Statement)
print(sentence.string) // "This is a sentence."

//: Creational Patterns
//: --------------------

//: ## Singleton / Shared Instance

//: This is a simple example of a shared instance. The sharedInstance static
//: property can be accessed from anywhere to ensure the same instance is
//: always used
class AddressBookShared {
    static let sharedInstance = AddressBookShared()

    func logContacts() {
        // ...
    }
}

AddressBookShared.sharedInstance.logContacts()

//: This is a simple example of a singleton. The singleton static
//: property can be accessed from anywhere to ensure the same instance is
//: always used and having a private initializer also ensures no other instances
//: can be created
class AddressBookSingleton {
    static let singleton = AddressBookSingleton()

    private init() {}

    func logContacts() {
        // ...
    }
}

AddressBookSingleton.singleton.logContacts()

//: ## Abstract factory

//: Below is an example of a factory object that allows for the easy creation
//: of new ball instances
struct Ball {
    let color: String
    let owningPlayer: Int
}

struct BallFactory {
    let color: String
    let owningPlayer: Int

    func createNewBall() -> Ball {
        return Ball(
            color: self.color,
            owningPlayer: self.owningPlayer
        )
    }
}

let player1Factory = BallFactory(
    color: "Red", owningPlayer: 1
)
let player2Factory = BallFactory(
    color: "Green", owningPlayer: 1
)

let ball1 = player1Factory.createNewBall()

//: Using associated values effectively

//: ### Replacing class hierarchies

//: From chapter 3: an enumeration to represent a distance measurement
enum Height {
    case Imperial(feet: Int, Inches: Double)
    case Metric(meters: Double)
    case Other(String)
}

//: This enum allows represnting two different types of workouts
enum Workout {
    case ForTime(seconds: Int)
    case ForRepts(movements: [(name: String, reps: Int)])
}

//: ### Concisely representing state

//: Here we can use an enumeration to represent either a successful result
//: or a failed result with a failure reason
enum NumberResult {
    case Success(value: Int)
    case Failure(reason: String)
}

func divide(first: Int, by second: Int) -> NumberResult {
    guard second != 0 else {
        return .Failure(reason: "Cannot divide by zero")
    }
    return .Success(value: first / second)
}

//: This enumeration allows us to represent the various states a download
//: can move through only making the currently relevant data available
enum DownloadState {
    case Pending
    case InProgress(percentComplete: Float)
    case Complete(data: String)
}

//: Extending system types to reduce code
//: ---------------------------------------

//: We can extend the Float type to make it easy to print it out as a percentage
//: out of 100 with a percent symbol after it
extension Float {
    var percentString: String {
        return "\(self * 100)%"
    }
}
let myPercent: Float = 0.32
print(myPercent.percentString) // 32.0%

//: We can alternatively write a class using the composite pattern to achieve a more
//: robust but less conscise implementation
struct Percent: CustomStringConvertible {
    let value: Float

    var description: String {
        return "\(self.value * 100)%"
    }
}
print(Percent(value: 0.3))

//: Lazy properties
//: ----------------

//: ### Avoid unnecessary memory usage

//: The lazy property below is not set even though we create an instance
//: of the type because we have not accessed it yet. This prevents it from
//: takin up unecessary memory
struct MyType {
    lazy var largeString = "some String"
}
let instance = MyType()

//: ### Avoid unnecessary processing

//: Here we combine a lazy property with a self-evaluating closure to delay
//: processing until it is necessary
class Directory {
    lazy var subDirectories: [Directory] = {
        var loaded = [Directory]()
        // Load subdirectories into 'loaded'
        return loaded
    }()
}
