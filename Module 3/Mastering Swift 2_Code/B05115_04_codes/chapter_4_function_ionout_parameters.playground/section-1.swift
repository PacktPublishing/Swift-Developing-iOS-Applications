// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func reverse(inout first: String, inout second: String) {
    let tmp = first
    first = second
    second = tmp
}

var one = "One"
var two = "Two"
reverse(&one, second: &two)
print("one: \(one)  two: \(two)")
