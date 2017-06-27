//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var stringArray = ["Jimmy", "Timmy", "Sammy", "Tammy", "Kim"]
var intArray = [1, 2, 4, 9, 16, 23, 42]
var doubleArray = [1.7, 3.6, 11.10, 42.3, 17.2]
var nothingArray = [Int]()

func returnFirst<ElementType>(array: [ElementType]) -> ElementType? {
    return (array.count > 0) ? array[0] : nil
}


returnFirst(array: intArray)
returnFirst(array: stringArray)
returnFirst(array: doubleArray)
returnFirst(array: nothingArray)