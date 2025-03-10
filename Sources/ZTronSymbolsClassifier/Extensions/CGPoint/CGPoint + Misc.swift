import Foundation

extension CGPoint {
    func dot(_ other: CGPoint) -> Double {
        return x * other.x + y * other.y
    }
    
    func norm() -> Double {
        return sqrt(self.dot(self))
    }
    
    func euclideanDistance(to other: CGPoint) -> Double {
        return (self - other).norm()
    }

    func manhattanDistance(to other: CGPoint) -> Double {
        return abs(self.x - other.x) + abs(self.y - other.y)
    }
    
    public static func ~~(_ lhs: CGPoint, _ rhs: CGPoint) -> Bool {
        return lhs.euclideanDistance(to: rhs) < Double.EPS
    }
    
    
    static func lerp(_ a: CGPoint, _ b: CGPoint, _ t: Double) -> CGPoint {
        assert(t >= 0 && t <= 1)
        return a + t*(b - a)
    }
    
    fileprivate static func minimumDistancePoint(_ thePoint: CGPoint, theSegmentA: CGPoint, theSegmentB: CGPoint) -> CGPoint {
        let scalar = (thePoint - theSegmentA).dot(theSegmentB - theSegmentA)/pow(theSegmentA.euclideanDistance(to: theSegmentB), 2.0)
        
        if scalar <= 0 {
            return theSegmentA
        } else {
            if scalar >= 1 {
                return theSegmentB
            } else {
                return theSegmentA + scalar * (theSegmentB - theSegmentA)
            }
        }
    }
    
    internal static func pointLineSegmentDistance(_ thePoint: CGPoint, theSegmentA: CGPoint, theSegmentB: CGPoint) -> Double {
        return thePoint.euclideanDistance(to: Self.minimumDistancePoint(thePoint, theSegmentA: theSegmentA, theSegmentB: theSegmentB))
    }
 
    public static func pointHullDistance(_ thePoint: CGPoint, theHull: ConvexHull) -> Double {
        guard !theHull.isEmpty else { fatalError("Can't compute distance from an empty convex hull in \(#file):\(#line) in \(#function)") }
        guard theHull.count > 1 else { return thePoint.euclideanDistance(to: theHull[0]) }
        
        var minDistance: Double = .infinity
        for i in 0..<theHull.count {
            let currentPoint = theHull[i]
            let nextPoint = theHull[(i + 1) % theHull.count]
            
            let currentDistance = Self.pointLineSegmentDistance(thePoint, theSegmentA: currentPoint, theSegmentB: nextPoint)
            
            if currentDistance < minDistance {
                minDistance = currentDistance
            }
        }
        
        return minDistance
    }
    
    static func concatenateStrokes(array: Strokes) -> Stroke {
        var concatenated: Stroke = .init()
        
        for stroke in array {
            for point in stroke {
                concatenated.append(point)
            }
        }
        
        return concatenated
    }
}

internal extension Stroke {
    func toString() -> String {
        var theString = "[\n"
        for point in self {
            theString += "(\(point.x), \(point.y)),\n"
        }
        theString += "]\n"
        return theString
    }
    
    func toCGString() -> String {
        var theString = "[\n"
        for point in self {
            theString += "CGPoint(x: \(point.x), y: \(point.y)),\n"
        }
        theString += "]\n"
        return theString
    }
}
