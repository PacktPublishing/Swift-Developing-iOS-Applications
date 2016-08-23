// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func sayHello(name: String) {
    print("Hello \(name)")
}

func sayHello2(name: String) ->String {
    let retString = "Hello " + name
    return retString
}

func test(name: String, greeting: String) ->Void {
    print("\(greeting) \(name)")
}

func sayHello3(name: String, greeting: String = "Bonjour") {
    print("\(greeting) \(name)")
}

func sayHello4(name: String, name2: String = "Kim", greeting: String = "Bonjour") {
    print("\(greeting) \(name) and \(name2)")
}


sayHello("Jon")

var message = sayHello2("Jon")

test("Jon", greeting: "Hello")

sayHello3("Jon")
sayHello3("Jon", greeting: "Hello")

sayHello4("Jon", greeting:"Hello")
