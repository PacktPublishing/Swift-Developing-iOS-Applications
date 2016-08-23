// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func sayHello(greeting: String, names: String...) {
    for name in names {
        print("\(greeting) \(name)")
    }
}


sayHello("Hello", names: "Jon","Kim")
