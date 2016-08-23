// Playground - noun: a place where people can play

import UIKit

func swapInts (inout a: Int, inout b: Int) {
    let tmp = a
    a = b
    b = tmp
}

func swapDoubles(inout a: Double, inout b: Double) {
    let tmp = a
    a = b
    b = tmp
}

func swapStrings(inout a: String, inout b: String) {
    let tmp = a
    a = b
    b = tmp
}

func swapGeneric<T>(inout a: T, inout b: T) {

    let tmp = a
    a = b
    b = tmp
}

func testDef<xyz>(a:xyz) {
    
}

func testGeneric<T,E>(a:T, b:E) {
    print("\(a)  \(b)")
}


func testGenericComparable<T: Comparable>(a: T, b: T) -> Bool{
    return a >= b
}

var a = 5
var b = 10
swapGeneric(&a, b: &b)
print("a:  \(a) b:  \(b)")

var c = "My String 1"
var d = "My String 2"
swapGeneric(&c, b: &d)
print("c:  \(c) d:  \(d)")

testGeneric(a, b: c)



