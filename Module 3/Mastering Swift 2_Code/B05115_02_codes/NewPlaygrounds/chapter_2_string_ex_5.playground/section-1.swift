// Playground - noun: a place where people can play

import UIKit

var stringOne = "one,two,three,four"
print(stringOne.stringByReplacingOccurrencesOfString("to", withString: "two"))



var path = "/one/two/three/four"
//Create start and end indexes
var startIndex = path.startIndex.advancedBy(4)
var endIndex = path.startIndex.advancedBy(14)

path.substringWithRange(Range<String.Index>(start:startIndex, end:endIndex))   //returns the String /two/three

path.substringToIndex(startIndex)  //returns the String /one
path.substringFromIndex(endIndex)  //returns the String /four\

path.characters.first
path.characters.last
var length = path.characters.count



