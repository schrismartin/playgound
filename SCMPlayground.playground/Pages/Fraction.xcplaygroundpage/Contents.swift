//: [Previous](@previous)

import Foundation

struct Fraction {
    
    private(set) var numerator: Int
    private(set) var denominator: Int
    
    init?(top: Int, bottom: Int) {
        guard bottom != 0 else {
            return nil
        }
        
        numerator = top
        denominator = bottom
    }
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        let numerator = lhs.numerator * rhs.denominator + rhs.numerator * lhs.denominator
        let denominator = lhs.denominator * rhs.denominator
        return Fraction(top: numerator, bottom: denominator)!.simplified()
    }
    
    func simplified() -> Fraction {
        guard abs(numerator) > 1 else { return self }
        
        for divisor in (1...abs(numerator)).reversed() where isReducible(by: divisor) {
            return Fraction(top: numerator / divisor, bottom: denominator / divisor)!
        }
        
        return self
    }
    
    private func isReducible(by divisor: Int) -> Bool {
        return abs(numerator) % divisor == 0 && abs(denominator) % divisor == 0
    }
}

extension Fraction: CustomStringConvertible {
    
    var description: String {
        return "\(numerator)/\(denominator)"
    }
    
}

let frac1 = Fraction(top: 10, bottom: 20)!
let simplified = frac1.simplified()

let frac2 = Fraction(top: 10, bottom: 20)!

let frac3 = frac1 + frac2
