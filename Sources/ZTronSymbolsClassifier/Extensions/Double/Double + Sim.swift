import Foundation

extension Double: Sim {
    public static let EPS: Double = 1e-10
    
    public static func ~~(_ lhs: Double, _ rhs: Double) -> Bool {
        return abs(lhs - rhs) < Double.EPS
    }
}
