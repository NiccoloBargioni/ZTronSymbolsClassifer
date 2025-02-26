import Foundation

public final class StrokeSample: Sample {
    private let strokes: Strokes
    
    public init(strokes: Strokes) {
        self.strokes = strokes
    }
    
    public func getStrokes() -> Strokes {
        var strokesCopy = Strokes.init()
        
        for stroke in self.strokes {
            strokesCopy.append(Stroke.init())
            for point in stroke {
                strokesCopy[strokesCopy.count - 1].append(
                    CGPoint(
                        x: point.x,
                        y: point.y
                    )
                )
            }
        }
        
        return strokesCopy
    }
    
    
    func distance(_ a: any Sample, _ b: any Sample) -> Double {
        guard let lhsStroke = a as? StrokeSample else { fatalError("Expected first parameter of type \(String(describing: StrokeSample.self)). \(type(of: a)) found instead.") }
        guard let rhsStroke = b as? StrokeSample else { fatalError("Expected first parameter of type \(String(describing: StrokeSample.self)). \(type(of: b)) found instead.") }
        
        let concatenatedLHS = CGPoint.concatenateStrokes(array: lhsStroke.strokes)
        let concatenatedRHS = CGPoint.concatenateStrokes(array: rhsStroke.strokes)
        
        return DTW.greedyDynamicTimeWarping(concatenatedLHS, concatenatedRHS) { lhs, rhs in
            return lhs.manhattanDistance(to: rhs)
        }
    }
    
    func distanceLowerBound(_ a: any Sample, _ b: any Sample) -> Double {
        guard let lhsStroke = a as? StrokeSample else { fatalError("Expected first parameter of type \(String(describing: StrokeSample.self)). \(type(of: a)) found instead.") }
        guard let rhsStroke = b as? StrokeSample else { fatalError("Expected first parameter of type \(String(describing: StrokeSample.self)). \(type(of: b)) found instead.") }

        let shiftedSeriesWidth: Int = 3
        let concatenatedLHS = CGPoint.concatenateStrokes(array: lhsStroke.strokes)
        let concatenatedRHS = CGPoint.concatenateStrokes(array: rhsStroke.strokes)
        
        guard concatenatedLHS.count > 3 && concatenatedRHS.count > 3 else { return .infinity }
        
        let lhsHullsCount = lhsStroke.strokes.count - shiftedSeriesWidth + 1
        let rhsHullsCount = rhsStroke.strokes.count - shiftedSeriesWidth + 1
        
        var lhsHulls: [ConvexHull] = .init()
        var rhsHulls: [ConvexHull] = .init()
        
        for i in 0..<lhsHullsCount {
            lhsHulls.append(lhsStroke.strokes[i].grahamConvexHull())
        }
        
        for i in 0..<rhsHullsCount {
            rhsHulls.append(rhsStroke.strokes[i].grahamConvexHull())
        }
        
        var lowerBoundDist: Double = .infinity
        
        for i in 0..<lhsHullsCount {
            for j in 0..<rhsHullsCount {
                let currrentDistance = [CGPoint].distance(lhsHulls[i], rhsHulls[j])
                if currrentDistance < lowerBoundDist {
                    lowerBoundDist = currrentDistance
                    if lowerBoundDist <= 0 {
                        return .zero
                    }
                }
            }
            
            if lowerBoundDist <= 0 {
                return .zero
            }
        }
        
        return lowerBoundDist
    }
}
