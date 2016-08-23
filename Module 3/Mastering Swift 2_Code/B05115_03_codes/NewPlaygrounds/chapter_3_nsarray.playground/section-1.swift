// Playground - noun: a place where people can play

import UIKit

var nsarr: NSArray = ["HI","There", 1,2]
if let arr = nsarr as? [String] {
    var newarr = arr as [String]
}

var nsarr2: NSArray = ["HI","There"]
if let arr2 = nsarr2 as? [String] {
    var newarr2 = arr2 as [String]
}

var nsarr3: NSArray = ["HI","There", 1]
var arr3 = nsarr as [AnyObject]
