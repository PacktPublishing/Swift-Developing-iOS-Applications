// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func sayHello(greeting: String, name: String, var count: Int) {    while (count > 0) {    print("\(greeting) \(name)")    count--    }}
sayHello("Hello", name: "Jon", count: 5)
