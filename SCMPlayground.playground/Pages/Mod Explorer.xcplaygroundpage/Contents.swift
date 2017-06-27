//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

extension Int {
    func absMod(by num: Int) -> Int {
        return (num + self % num) % num
    }
}

for i in -30...3 {
    print(i.absMod(by: 3))
}

//: [Next](@next)
