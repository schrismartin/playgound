//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let int = 25
let i = Int(sqrt(Double(int)))

var sum: Double = 0
var it = 1
while sum < 1 {
    let iteration = Double(it)
    sum += iteration / (365 - iteration)
    it += 1
}

sum
it