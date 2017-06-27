//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

/*
 Write a function that takes a string as input and returns a boolean that indicates whether the string is valid or not.
 You can assume that the string will only contain "(" and ")" characters. The string is valid IFF the following criteria are met:
 - Every "(" must be immediately followed by ")"
 - Every ")" must be immediately preceded by "("
 */

func validate(str: String) -> Bool {
    let numPairs = numParenthesisPair(str);
    return str.characters.count == numPairs * 2
}

func numParenthesisPair(_ str: String) -> Int {
    var parenthesisIsOpen = false
    var numberOfPairs = 0
    
    for character in str.characters {
        if character == "(" {
            parenthesisIsOpen = true
        }
        
        if character == ")", parenthesisIsOpen {
            parenthesisIsOpen = false
            numberOfPairs += 1
        }
    }
    
    return numberOfPairs
}
