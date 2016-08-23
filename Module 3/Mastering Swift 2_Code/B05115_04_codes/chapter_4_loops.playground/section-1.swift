// Playground - noun: a place where people can play

import UIKit

for var index = 1, i = 2; index<=4; index++ {
    print(index)
}


var countries = ["USA","UK", "IN"]
for var index = 0; index < countries.count; index++ {
    print(countries[index])
}

var dic = ["USA": "United States", "UK": "United Kingdom", "IN":"India"]

var keys  = Array(dic.keys)
for var index = 0; index < keys.count; index++ {
    print(dic[keys[index]]);
}


for index in 1...5 {
    print(index)
}

for item in countries {
    print(item)
}

for (abbr, name) in dic {
    print("\(abbr) --  \(name)")
}


var ran = 0
while ran < 4 {
    ran = Int(arc4random() % 5)
}

var ran2: Int
repeat {
    ran2 = Int(arc4random() % 5)
} while ran2 < 4
