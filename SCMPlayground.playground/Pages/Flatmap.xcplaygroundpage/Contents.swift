//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var a = [0, 1, 2, 3, 4]
let b = [5, 6, 7, 8, 9]

// Several Ways:
// Way 1
let c = [a, b].flatMap { $0 }
print(c)

// Way 2
a.append(contentsOf: b)
print(a)

// Way 3
a + b

//: [Next](@next)
