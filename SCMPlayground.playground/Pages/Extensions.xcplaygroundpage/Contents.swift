//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class Thing {
    
    var integer: Int
    var double: Double
    
    init(integer: Int, double: Double) {
        self.integer = integer
        self.double = double
    }
    
}

extension Thing {
    
    func add() -> Double {
        return Double(integer) + double
    }
    
}

