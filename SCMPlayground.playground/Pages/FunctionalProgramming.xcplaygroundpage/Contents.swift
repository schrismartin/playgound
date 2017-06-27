//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

func dumbDoubleEvens(array: [Int]) -> [Int] {
    var returned = [Int]()
    
    for item in array {
        if item % 2 == 0 {
            returned.append(item * 2)
        } else {
            returned.append(item)
        }
    }
    
    return returned
}


func doubleEvens(array: [Int]) -> [Int] {
    return array.map { $0.isEven ? $0 * 2 : $0 }
}

let thing = [0, 1, 2, 3, 4, 5, 6, 7, 8]

dumbDoubleEvens(array: thing)
doubleEvens(array: thing)


//: [Next](@next)