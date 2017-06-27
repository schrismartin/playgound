//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let items = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]

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

func lessDumbDoubleEvens(array: [Int]) -> [Int] {
    var returned = array
    
    for index in returned.indices where returned[index] % 2 == 0 {
        returned[index] *= 2
    }
    
    return returned
}

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

func doubleEvens(array: [Int]) -> [Int] {
    return array.map { $0.isEven ? $0 * 2 : $0 }
}

let dumb = measure() {
    _ = dumbDoubleEvens(array: items)
}

let lessDumb = measure() {
    _ = lessDumbDoubleEvens(array: items)
}

let map = measure {
    _ = doubleEvens(array: items)
}

print("Map is \(dumb / map) times faster than dumb")
print("Map is \(lessDumb / map) times faster than lessDumb")