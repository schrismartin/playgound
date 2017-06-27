import Foundation
import XCPlayground

public typealias MeasuredBlock = () -> Void

public struct ConfidenceInterval<ElementType: BinaryFloatingPoint>: CustomStringConvertible {
    public private(set) var min: ElementType
    public private(set) var max: ElementType
    public var difference: ElementType {
        return max - min
    }
    
    public var description: String {
        return "\(min)..<\(max)"
    }
}

public struct Metrics: CustomStringConvertible {
    public var mean: Double
    public var deviation: Double
    
    public var variance: Double {
        return deviation / Double(iterations)
    }
    
    public var iterations: Int
    
    public var confidence: ConfidenceInterval<Double> {
        let gausian = 1.96
        let rootN = sqrt(Double(iterations))
        
        let value = gausian * (deviation / rootN)
        return ConfidenceInterval(min: mean - value, max: mean + value)
    }
    
    public var description: String {
        return "Mean: \(mean), STD Dev: \(variance)"
    }
    
    public static func /(lhs: Metrics, rhs: Metrics) -> Double {
        return lhs.mean / rhs.mean
    }
}

//
// Calls a particular block the specified number of times, returning the average
// number of seconds it took to complete the code. If a name is supplied the time
// take for each iteration will be recorded
//
public func measure(name: String? = nil, iterations: Int = 30, for block: MeasuredBlock) -> Metrics {
    precondition(iterations > 0, "Iterations must be a positive integer")
    
    var total : Double = 0
    var samples = [Double]()
    
    for i in 1...iterations{
        let start = NSDate.timeIntervalSinceReferenceDate
        block()
        let took = Double(NSDate.timeIntervalSinceReferenceDate - start)
        
        samples.append(took)
        
        total += took
        if let name = name {
            print("\(name) \(i) – \(took) seconds")
        }
    }
    
    let mean = total / Double(iterations)
    
    var deviation = 0.0
    
    for result in samples {
        
        let difference = result - mean
        
        deviation += difference*difference
    }
    
    return Metrics(mean: mean, deviation: deviation, iterations: iterations)
}

extension Double{
    
    var milliSeconds : String {
        return String(format: "%03.2fms", self*1000)
    }
    
}

