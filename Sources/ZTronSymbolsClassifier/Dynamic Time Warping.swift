import Foundation

public class DTW {
    public init() { }
    
    
    /// Greedily computes the Dynamic Time Warping of two input time series.
    /// - Parameter lhsSequence: The first time sequence.
    /// - Parameter rhsSequence: The second time sequence.
    /// - Parameter measure: This is a function that takes two elements of the input sequences and returns a Double representing the distance between these two elements.
    public static func greedyDynamicTimeWarping<T>(_ lhsSequence: [T], _ rhsSequence: [T], measure: @escaping (T, T) -> Double) -> Double {
        guard rhsSequence.count > 0 else {
            return Self.greedyDynamicTimeWarping(rhsSequence, lhsSequence, measure: measure)
        }
        
        guard lhsSequence.count > 0 else {
            fatalError("Cannot compare empty series!")
        }
        
        var currentDistance = measure(lhsSequence[0], rhsSequence[0])
        var length = 1
                
        var lhsIndex: Int = 0
        var rhsIndex: Int = 0
        
        while(lhsIndex < lhsSequence.count - 1 && rhsIndex < rhsSequence.count) {
            let left = lhsIndex < lhsSequence.count - 1 ? measure(lhsSequence[lhsIndex + 1], rhsSequence[rhsIndex]) : .infinity
            let mid = lhsIndex < lhsSequence.count - 1  && rhsIndex < rhsSequence.count - 1 ? measure(lhsSequence[lhsIndex + 1], rhsSequence[rhsIndex + 1]) : .infinity
            let right = rhsIndex < rhsSequence.count - 1 ? measure(lhsSequence[lhsIndex], rhsSequence[rhsIndex + 1]) : .infinity
            
            var min = left
            var moveLHS = 1
            var moveRHS = 0
            
            if mid < min {
                min = mid
                moveLHS = 1
                moveRHS = 1
            }
            
            if right < min {
                min = right
                moveLHS = 0
                moveRHS = 1
            }
            
            currentDistance += min
            length += 1
            
            lhsIndex += moveLHS;
            rhsIndex += moveRHS;
        }
        
        while lhsIndex == lhsSequence.count - 1 && rhsIndex < rhsSequence.count {
            currentDistance += measure(lhsSequence[lhsIndex], rhsSequence[rhsIndex])
            rhsIndex += 1
            length += 1
        }
        
        while rhsIndex == rhsSequence.count - 1 && lhsIndex < lhsSequence.count {
            currentDistance += measure(lhsSequence[lhsIndex], rhsSequence[rhsIndex])
            lhsIndex += 1
            length += 1
        }

        return currentDistance / Double(length)
    }
    
    
    /// Computes the constrained Dynamic Time Warping of two input time series.
    /// - Parameter lhsSequence: The first time sequence.
    /// - Parameter rhsSequence: The second time sequence.
    /// - Parameter windowSize: The window length to compute the DTW over.
    /// - Parameter measure: This is a function that takes two elements of the input sequences and returns a Double representing the distance between these two elements.
    public static func constrainedDynamicTimeWarping<T>(_ lhsSequence: [T], _ rhsSequence: [T], windowSize: Int, measure: @escaping (T, T) -> Double) -> Double {
        var costMatrix: [[[Double]]] = .init(repeating: [], count: lhsSequence.count + 1)
        
        for i in 0..<costMatrix.count {
            costMatrix[i] = .init(repeating: [], count: rhsSequence.count + 1)
        }
        
        for i in 0..<costMatrix.count {
            for j in 0..<costMatrix[i].count {
                costMatrix[i][j] = .init(arrayLiteral: .infinity, 0)
            }
        }
        
        costMatrix[0][0][0] = 0
        costMatrix[0][0][1] = 1
        
        for i in 1...lhsSequence.count {
            for j in ((i - windowSize > 1) ? i - windowSize : 1)...((i + windowSize < rhsSequence.count ? i + windowSize : rhsSequence.count)) {
                let tempCost: Double = measure(lhsSequence[i-1], rhsSequence[j-1])
                let minPrev: Double = Swift.min( Swift.min(costMatrix[i][j-1][0], costMatrix[i-1][j-1][0]), costMatrix[i-1][j][0])
                
                costMatrix[i][j][0] = tempCost + minPrev
                costMatrix[i][j][1] = costMatrix[i-1][j][1] + 1
            }
        }
        
        return costMatrix[lhsSequence.count][rhsSequence.count][0]/costMatrix[lhsSequence.count][rhsSequence.count][1]
    }
    
    
    /// Computes the unconstrained Dynamic Time Warping of two input time series.
    /// - Parameter lhsSequence: The first time sequence.
    /// - Parameter rhsSequence: The second time sequence.
    /// - Parameter measure: This is a function that takes two elements of the input sequences and returns a Double representing the distance between these two elements.
    public static func unconstrainedDynamicTimeWarping<T>(_ lhsSequence: [T], _ rhsSequence: [T], measure: @escaping (T, T) -> Double) -> Double {
        var costMatrix: [[Double]] = []
        var pathLengthMatrix: [[Int]] = []
        
        for _ in 0...lhsSequence.count + 1 {
            costMatrix.append([Double].init(repeating: 0.0, count: rhsSequence.count + 1))
            pathLengthMatrix.append([Int].init(repeating: 0, count: rhsSequence.count + 1))
        }
        
        for i in 0...lhsSequence.count {
            for j in 0...rhsSequence.count {
                costMatrix[i][j] = .infinity
                pathLengthMatrix[i][j] = 0
            }
        }
        
        costMatrix[0][0] = 0
        pathLengthMatrix[0][0] = 0
        
        for i in 1...lhsSequence.count {
            for j in 1...rhsSequence.count {
                let cost = measure(lhsSequence[i-1], rhsSequence[j-1])
                let minCost = Swift.min(costMatrix[i-1][j], Swift.min(costMatrix[i][j-1], costMatrix[i-1][j-1]))
                let minCount = Swift.min(pathLengthMatrix[i-1][j], Swift.min(pathLengthMatrix[i][j-1], pathLengthMatrix[i-1][j-1]))
                
                costMatrix[i][j] = cost + minCost
                pathLengthMatrix[i][j] = minCount + 1
            }
        }

        return costMatrix[lhsSequence.count][rhsSequence.count] / Double(pathLengthMatrix[lhsSequence.count][rhsSequence.count])
    }
}
