//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

class NestedObject {
    var value: String = "Hello"
    
    init(string: String) {
        value = string
    }
}

struct Object {
    var nestedObject: NestedObject
}

var newNestedObject = NestedObject(string: "OldValue")
let object = Object(nestedObject: newNestedObject)
let newObject = object

object.nestedObject.value = "NewValue"
print(newObject.nestedObject.value)
