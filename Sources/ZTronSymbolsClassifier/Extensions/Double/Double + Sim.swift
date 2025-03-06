import Foundation

extension Double: Sim {
    public static let EPS: Double = 1e-10
    
    public static func ~~(_ lhs: Double, _ rhs: Double) -> Bool {
        return abs(lhs - rhs) < Double.EPS
    }
}

extension Range where Bound: FloatingPoint {
    internal func normalizeInRange(_ t: Bound) -> Bound {
        return (t - self.lowerBound) / (self.upperBound - self.lowerBound)
    }
    
    internal func clamp(_ t: Bound) -> Bound {
        if t <= self.lowerBound { return lowerBound }
        if t >= self.upperBound { return upperBound }
        else { return t }
    }
}
