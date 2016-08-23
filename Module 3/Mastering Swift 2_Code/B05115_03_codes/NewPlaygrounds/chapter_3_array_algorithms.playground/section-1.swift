// Playground - noun: a place where people can play

import UIKit

var arraySort = [9,3,6,2,8,5]
arraySort.sortInPlace(){ $0 < $1 }
for i in arraySort {
    print(i)
}
//arraySort contains 2,3,5,6,8 and 9

var arraySort2 = [9,3,6,2,8,5]
arraySort2.sortInPlace(){ $1 < $0 }
//arraySort2 contains 9,8,6,5,3 and 2

var arraySorted = [9,3,6,2,8,5]
let sorted = arraySorted.sort(){ $0 < $1 }
//sorted contains 2,3,5,6,8 and 9
//arraySorted contains 9,3,6,2,8 and 5
for i in sorted {
    print("--",i)
}

var arrayFiltered = [1,2,3,4,5,6,7,8,9]
let filtered = arrayFiltered.filter{$0 > 3 && $0 < 7}
//filtered contains 4,5 and 6

var city = ["Boston", "London", "Chicago", "Atlanta"]
let filtered2 = city.filter{$0.rangeOfString("o") != nil}
//filtered2 contains “Boston”, “London” and “Chicago”

var arrayMap = [10, 20, 30, 40]
let applied = arrayMap.map{ $0 / 10}
//applied contains 1,2,3 and 4

var arrayMap2 = [1, 2, 3, 4]
let applied2 = arrayMap2.map{ "Num:\($0)"}
//applied2 contains “num:1”, “num:2”, “num:3” and “num:4”

var arr = ["one", "two", "three"]
for item in arr {
    print(item)
}

for (index,value) in arr.enumerate() {
    print("\(index) \(value)")
}

