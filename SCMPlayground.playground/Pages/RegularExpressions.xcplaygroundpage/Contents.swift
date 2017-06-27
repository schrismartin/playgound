import Foundation

let pattern = "^([A-Za-z\\s]+)([0-9]+)\\s*$"
let regex = try? NSRegularExpression(pattern: pattern, options: [])
let string = "Homework 1"
let range = NSRange(location: 0, length: string.characters.count)
let matches = regex?.matches(in: string, options: [], range: range)

regex?.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "$1 $2")