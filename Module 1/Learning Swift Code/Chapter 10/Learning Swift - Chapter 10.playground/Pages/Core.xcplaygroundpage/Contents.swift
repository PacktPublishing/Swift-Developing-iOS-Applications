//: Learning Swift


//: Chapter 10 – Harnessing the Past: Understanding and Translating Objective-C
//: ======================================================================

//: Constants and variables
//: ------------------------

//: Here we define a variable called "variableNumber" that is of type int
var variableNumber: Int
//int variableNumber;

//: Here we define a constant called "constantNumber"
let constantNumber = 10
//const int number = 10;

//: ### Reference Types

//: Any type in Objective-C can be changed to a reference type by using an asterix
// int* number;

//: Reference types are also like optionals because they can be nil and require
//: unwrapping
// int* number = nil;
// int actualNumber = *number;

//: Reference types in Objective-C are also not as type safe. We can accidently assign
//: a value to the wrong type
//double *another = (double *)number;

//: The string type in Objective-C is called NSString and literals must contain
//: an @ before them
var myString = "Hello World!"
// NSString *myString = @"Hello World!";

//: Containers
//: -----------

//: ### Arrays

//: Initializing an array
let array = [Int]()
// NSArray *array = [NSArray alloc];
// array = [array init];
// NSArray *array2 = [[NSArray alloc] init];
// NSArray *array3 = [NSArray new];


//: Adding to an array
//    NSMutableArray *array = [NSMutableArray new];
//    [array addObject:@"Hello World!"];

//: Accessing an object
// NSString *myString = [array objectAtIndex:0];
// NSString *myString2 = array[0];
// NSArray *myString3 = array[0];

//: Removing an object
//   [array removeObjectAtIndex:0];

//: Array literals
//    NSArray *array = @[@"one", @"two", @"three"];

//: ### Dictionaries

//: Initializing a dictionary
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    NSDictionary *dict2 = [NSDictionary new];

//: Setting a value
//    [dict setObject:@"World" forKey:@"Hello"];

//: Accessing an object
//    NSString *myString = [dict objectForKey:@"Hello"];
//    NSString *myString2 = dict[@"Hello"];

//: Removing a value
//    [dict removeObjectForKey:@"Hello"];

//: Dictionary literals
//    NSDictionary *dict3 = @{@1: @"one", @2: @"two", @3: @"three"};

//: Control flow
//: -------------

//: Printing to the console
var name = "Sarah"
print("Hello \(name)")
// NSString *name = @"Sarah";
// NSLog(@"Hello %@", name);

//: ### Conditionals

var invitees = ["Sarah", "Jamison", "Roana"]
if invitees.count > 20 {
    print("Too many people invited")
}
//NSArray *invitees = @[@"Sarah", @"Jamison", @"Roana"];
//if (invitees.count > 20) {
//    NSLog(@"Too many people invited");
//}

//: ### Switches

//: Switches in Objetive-C can only be used for equality comparisons
switch invitees.count {
    case 1:
        print("One person invited")
    case 2:
        print("Two people invited")
    default:
        print("More than two people invited")
}
//switch (invitees.count) {
//    case 1:
//        NSLog(@"One person invited");
//        break;
//
//    case 2:
//        NSLog(@"Two people invited");
//        break;
//        
//    default:
//        NSLog(@"More than two people invited");
//        break;
//}

//: ### Loops

//: While loop

var index = 0
while index < invitees.count {
    print("\(invitees[index]) is invited");
    index++
}
//int index = 0;
//while (index < invitees.count) {
//    NSLog(@"%@ is invited", invitees[index]);
//    index++;
//}

//: For-in loops require that you specify the type you are looping through with
var showsByGenre = [
    "Comedy": "Modern Family",
    "Drama": "Breaking Bad"
]
for (genre, show) in showsByGenre {
    print("\(show) is a great \(genre)")
}
//NSDictionary *showsByGenre = @{
//    @"Comedy": @"Modern Family",
//    @"Drama": @"Breaking Bad"
//};

//: There is no way to loop through a list of numbers concisely. Instead Objective-C
//: has a different type of loop called just a for loop
//for (NSString *genre in showsByGenre) {
//    NSLog(@"%@ is a great %@", showsByGenre[genre], genre);
//}
for number in 1 ... 10 {
    print(number)
}
//for (int number = 1; number <= 10; number++) {
//    NSLog(@"%i", number);
//}

//: ### Functions

//: A basic function that takes no arguments and doesn't return anything
func sayHello() {
    print("Hello World!");
}
sayHello()
//void sayHello() {
//    NSLog(@"Hello World!");
//}
//sayHello();

//: Function that takes arguments and returns a value
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
addInviteeToListIfSpotAvailable(invitees, newInvitee: "Roana")

//NSArray *addInviteeToListIfSpotAvailable
//(
//    NSArray *invitees,
//    NSString *newInvitee
//)
//{
//    if (invitees.count >= 20) {
//        return invitees;
//    }
//    NSMutableArray *copy = [invitees mutableCopy];
//    [copy addObject:newInvitee];
//    return copy;
//}
//addInviteeToListIfSpotAvailable(invitees, @"Roana");

//: Types
//: -------

//: ### Structures

//: Objective-C structures are very limited. They cannot contain
//: anything but value types and cannot have any methods
struct Cylinder {
    var radius: Int
    var height: Int
}
//var c = Cylinder(radius: 10, height: 10)
//typedef struct {
//    int radius;
//    int height;
//} Cylinder;
//Cylinder c;
//c.radius = 10;
//c.height = 5;

//: ### Enumerations

//: Enumerations are also very restrictive to just a simple list of possible values
enum PrimaryColor {
    case Red
    case Green
    case Blue
}
//typedef enum {
//    PrimaryColorRed,
//    PrimaryColorGreen,
//    PrimaryColorBlue,
//} PrimaryColor;

var color = PrimaryColor.Blue
//PrimaryColor color = PrimaryColorBlue;

//: ### Classes

//: An Objective-C class is made up of an interfacne and an implementation. Also,
//: Objective-C does not allow specifying default values so must use an initializer
class Contact {
    var firstName: String = "First"
    var lastName: String = "Last"
}
//@interface Contact : NSObject {
//}
//@property NSString *firstName;
//@property NSString *lastName;
//@end
//
//@implementation Contact
//
//- (id)init {
//    self = [super init];
//    if (self) {
//        self.firstName = @"First";
//        self.lastName = @"Last";
//    }
//    return self;
//}
//
//@end

//: Objective-C proprerties can also be declared as weak or make them readonly

class Car{}
class SteeringWheel {
    weak var car: Car?
}
//@class Car;
//@interface SteeringWheel : NSObject
//@property (unsafe_unretained) Car *car;
//@end

//: Methods that take parameters

class Ball {
    var radius: Double = 0

    func growByAmount(amount: Double) {
        self.radius += amount
    }
}
//@interface Ball : NSObject
//@property double radius;
//@end
//
//@implementation Ball
//- (void)growByAmount:(double)amount {
//    self.radius += amount;
//}
//@end

//: Class methods

//@implementation Contact
//+ (void)printAvailablePhonePrefixes {
//    NSLog(@"+1");
//}
//@end
// [Contact printAvailablePhonePrefixes];

//: ### Categories

//: These are the same thing as extensions in Swift
extension Contact {
    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}
//@interface Contact (Helpers)
//- (NSString *)fullName;
//@end
//
//@implementation Contact (Helpers)
//- (NSString *)fullName {
//    return [self.firstName stringByAppendingFormat:@" %@", self.lastName];
//}
//@end

//: Categories can add properties but they cannot be stored properties

//@interface Contact (Helpers)
//@property NSString *fullName;
//@end
//
//@implementation Contact (Helpers)
//- (NSString *)fullName {
//    return [self.firstName stringByAppendingFormat: @" %@",
//        self.lastName
//    ];
//}
//- (void)setFullName:(NSString *)fullName {
//    NSArray *components = [fullName
//        componentsSeperatedByString:@" "];
//    ];
//    if (components.count > 0) {
//        self.firstName = components[0];
//    }
//    if (components.count > 1) {
//        self.lastName = components[1];
//    }
//}

//: ### Protocols

//: Defining a protocol
protocol StringContainer {
    var count: Int {get}
    
    func addString(string: String)
    func enumerateStrings(handler: () -> ())
}
//@protocol StringContainer
//@property (readonly) NSInteger count;
//- (void)addString:(NSString *)string;
//- (void)enumerateStrings:(void(^)(NSString *))handler;
//@end

//: Implementing a protocol
//@interface StringList : NSObject <StringContainer>
//@property NSMutableArray *contents;
//@end
//@implementation StringList

//- (NSInteger)count {
//    return [self.contents count];
//}
//
//- (void)addString:(NSString *)string {
//    if (self.contents == nil) {
//        self.contents = [NSMutableArray new];
//    }
//    [self.contents addObject:string];
//}
//
//- (void)enumerateStrings:(void (^)(NSString *))handler {
//    for (NSString *string in self.contents) {
//        handler(string);
//    }
//}
//
//@end

//: Declaring a variable as implementing a protocol
//id<StringContainer> container = [StringList new];

//: ### Blocks

//: Defining and calling a block
//int (^doubleClosure)(int) = ^(int input) {
//    return input * 2;
//};
//doubleClosure(2);

//: Defining a function that takes a closure
//id firstInArrayPassingTest(NSArray *array, BOOL(^test)(id)) {
//    for (id element in array) {
//        if (test(element)) {
//            return element;
//        }
//    }
//    return nil;
//}
//firstInArrayPassingTest(array, ^BOOL(id test) {
//    return false;
//});

//: Defining a method that takes a closure
//- (id)firstInArray:(NSArray *)array passingTest:(BOOL(^)(id test))test
//{
//    for (id element in array) {
//        if (test(element)) {
//            return element;
//        }
//    }
//    return nil;
//}
//[self firstInArray: array passingTest:^BOOL(id test) {
//    return false;
//}];

//: Weakly capturing variables
//@interface Ball: NSObject
//@property int xLocation;
//@property (strong) void (^onBounce)();
//@end
//@implementation Ball
//@end
//
//Ball *ball = [Ball new];
//__weak Ball *weakBall = ball;
//ball.onBounce = ^{
//    NSLog(@"%d", weakBall.xLocation);
//};

//: Projects
//: ----------

//: ### Header files

//: Importing another header
//#import <Foundation/Foundation.h>
//#import "Card.h"
//
//@interface SteeringWheel : NSObject
//@property (weak) Car *car;
//@end

//: Declaring the existend of a class without having to import its header
//@class Car;
//
//@interface SteeringWheel : NSObject
//@property (weak) Car *car;
//@end

//: ### Implementation files

//: Anonymous category
//@interface SteeringWheel ()
//@property NSString *somePrivateProperty;
//- (void)somePrivateMethod;
//@end
