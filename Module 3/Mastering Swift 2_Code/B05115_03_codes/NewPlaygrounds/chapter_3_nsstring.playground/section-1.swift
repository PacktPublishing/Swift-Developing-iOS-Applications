// Playground - noun: a place where people can play

import UIKit

var str = "Hello World from Swift"
str.cStringUsingEncoding(NSUTF8StringEncoding)


var str2 = "1234"

var num = Int(str2) //num contains the number 1234

func testFunc(test: String) {
    print(test)
}

var nsstr: NSString = "abc"
testFunc(nsstr as String)

var ns: NSString = "1234"
var num2 = Int(ns as String)
