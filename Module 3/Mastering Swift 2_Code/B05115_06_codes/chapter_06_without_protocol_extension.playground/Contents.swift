//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol PersonProtocol {
    var firstName: String {get set}
    var lastName: String {get set}
    var profession: String {get}
    var birthDate: NSDate {get set}
    
    init (firstName: String, lastName: String, birthDate: NSDate)
    func getAge() -> Int
}


class FootballPlayer: PersonProtocol {
    var firstName: String
    var lastName: String
    let profession = "Football Player"
    var birthDate: NSDate
    var position = "Unassigned"
    
    required init (firstName: String, lastName: String, birthDate: NSDate) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    
    func getAge() -> Int {
        let unit = NSCalendarUnit.Year.union(NSCalendarUnit.Day).union(NSCalendarUnit.Month)
        let now = NSCalendar.currentCalendar().components(unit, fromDate: NSDate())
        let bDate = NSCalendar.currentCalendar().components(unit, fromDate: birthDate)
        
        var age = now.year - bDate.year
        
        if bDate.month > now.month  {
            age--
        } else if bDate.month == now.month && bDate.day > now.day {
            age--
        }
        return age
    }
}

struct SwiftProgrammer: PersonProtocol {
    var firstName: String
    var lastName: String
    let profession = "Swift Programmer"
    var birthDate: NSDate
    var ability = "Novice"
    
    init (firstName: String, lastName: String, birthDate: NSDate) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    
    func getAge() -> Int {
        let unit = NSCalendarUnit.Year.union(NSCalendarUnit.Day).union(NSCalendarUnit.Month)
        let now = NSCalendar.currentCalendar().components(unit, fromDate: NSDate())
        let bDate = NSCalendar.currentCalendar().components(unit, fromDate: birthDate)
        
        var age = now.year - bDate.year
        
        if bDate.month > now.month  {
            age--
        } else if bDate.month == now.month && bDate.day > now.day {
            age--
        }
        return age
    }
}

var bDateProgrammer = NSCalendar.currentCalendar().dateWithEra(1, year: 1968, month: 8, day: 11, hour: 0, minute: 0, second: 0, nanosecond: 0)!
var programmer = SwiftProgrammer(firstName: "Jon", lastName: "Hoffman", birthDate: bDateProgrammer)
programmer.ability = "Expert"
print(programmer.getAge())

var bDatePlayer = NSCalendar.currentCalendar().dateWithEra(1, year: 1965, month: 07, day: 12, hour: 0, minute: 0, second: 0, nanosecond: 0)!
var player = FootballPlayer(firstName: "Dan", lastName: "Marino", birthDate: bDatePlayer)
player.position = "Quarterback"
print(player.getAge())


var people: [PersonProtocol] = []
people.append(programmer)
people.append(player)
print(people.count)


var p = people[0] as? SwiftProgrammer

for person in people {

    switch (person) {
    case is SwiftProgrammer:
        var test = person as! SwiftProgrammer
    case is FootballPlayer:
        var test = person as! FootballPlayer
    default:
        break
        
    }
    print("\(person.firstName) \(person.lastName): \(person.profession)")
}

var myPerson: PersonProtocol

myPerson = SwiftProgrammer(firstName: "Jon", lastName: "Hoffman", birthDate: bDateProgrammer)
print("\(myPerson.firstName) \(myPerson.lastName)")

myPerson = FootballPlayer(firstName: "Dan", lastName: "Marino", birthDate: bDatePlayer)
print("\(myPerson.firstName) \(myPerson.lastName)")


for person in people where person is SwiftProgrammer {
    print(person.firstName)
}





