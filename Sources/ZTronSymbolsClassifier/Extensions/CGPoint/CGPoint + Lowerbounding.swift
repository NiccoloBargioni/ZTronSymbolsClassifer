import Foundation

public typealias ConvexHull = [CGPoint]

 extension CGPoint {
    static func isConvex(_ lhs: CGPoint, _ chs: CGPoint, _ rhs: CGPoint) -> Bool {
        return (chs.x - lhs.x) * (rhs.y - lhs.y) - (chs.y - lhs.y) * (rhs.x - lhs.x) > 0
    }

    static func isConcave(_ lhs: CGPoint, _ chs: CGPoint, _ rhs: CGPoint) -> Bool {
        return !CGPoint.isConvex(lhs, chs, rhs)
    }
     
    func angle() -> Double {
        guard self.x != 0 && self.y != 0 else { return .infinity }
        return self.x / self.y
    }
     
     static func compare(_ lhs: CGPoint, _ rhs: CGPoint) -> Int {
         let lhsAngle = lhs.angle()
         let rhsAngle = rhs.angle()
         
         let lhsNorm = lhs.norm()
         let rhsNorm = rhs.norm()
         
         if lhsAngle != rhsAngle {
             return rhsAngle < lhsAngle ? -1 : 1
         } else {
             return rhsNorm < lhsNorm ? -1 : 1
         }
     }
     
     static func step(hull: ConvexHull, point: CGPoint) -> ConvexHull {
         var hullCopy = ConvexHull(hull)
         
         if hull.count <= 2 {
             hullCopy.append(point)
         } else {
             if CGPoint.isConvex(hull[hull.count - 2], hull[hull.count - 1], point) {
                 hullCopy.append(point)
             } else {
                 hullCopy[hullCopy.count - 1] = point
             }
         }
         
         return hullCopy
     }
}


public extension Array where Element == CGPoint {
    func minPoint() -> CGPoint {
        guard let first = self.first else {
            fatalError("Called \(#function) on empty points list")
        }
        
        var minP = first
        
        for point in self {
            if point.y < minP.y || (point.y == minP.y && point.x < minP.x) {
                minP = point
            }
        }
        
        return minP
    }
    
    func sortPoints(relativeTo minP: CGPoint) -> Self {
        var result = [CGPoint].init()
        
        for point in self {
            result.append(
                CGPoint(
                    x: point.x - minP.x,
                    y: point.y - minP.y
                )
            )
        }
        
        result.sort { lhs, rhs in
            return CGPoint.compare(lhs, rhs) < 0
        }
        
        return result
    }
    
    func grahamConvexHull() -> ConvexHull {
        guard self.count > 4 else { return self }
        
        let minP = self.minPoint()
        let sorted = self.sortPoints(relativeTo: minP)
        
        var hull = Self.init()
        
        for point in sorted {
            hull = CGPoint.step(hull: hull, point: point)
        }
        
        return hull
    }
}
