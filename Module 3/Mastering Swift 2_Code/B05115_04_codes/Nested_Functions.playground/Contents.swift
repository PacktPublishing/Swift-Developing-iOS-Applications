//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func sort(inout numbers: [Int]) {
    func reverse(inout first: Int, inout second: Int) {
        let tmp = first
        first = second
        second = tmp
    }
    
    var count = numbers.count
    
    while count > 0 {
        for var i = 1; i < count; i++ {
            if numbers[i] < numbers[i-1] {
                reverse(&numbers[i], second: &numbers[i-1])
            }
        }
        count--
    }
}


var nums = [6,2,5,3,1]

sort(&nums)
for num in nums {
    print(num)
}
