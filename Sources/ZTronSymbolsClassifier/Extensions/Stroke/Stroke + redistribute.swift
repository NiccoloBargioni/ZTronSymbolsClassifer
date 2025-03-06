import Foundation

internal extension Stroke {
    func normalizedDistances() -> [Double] {
        let totalLength = self.strokeLength()
        var normalizedDistances: [Double] = .init(arrayLiteral: 0.0)
        
        for i in 1..<self.count {
            var sumOfDistances: Double = .zero
            for j in 0..<i {
                sumOfDistances += self[j].euclideanDistance(to: self[j+1])
            }
            
            normalizedDistances.append(sumOfDistances / totalLength)
        }
        
        return normalizedDistances
    }
    
    private func findBounds(for normalizedDistance: Double, index: Int) -> Int {
        assert(normalizedDistance >= 0 && normalizedDistance <= 1)
        assert(index >= 0)
        
        guard index < self.count - 1 else { return self.count - 1 }
        let distances = self.normalizedDistances()
        
        if normalizedDistance >= distances[index] && normalizedDistance <= distances[index + 1] {
            return index
        } else {
            return findBounds(for: normalizedDistance, index: index + 1)
        }
    }
    
    private func findBoundsNormalized(for normalizedDistance: Double, index: Int) -> (Int, Double) {
        let distances = self.normalizedDistances()
        return (index, (distances[index]..<distances[index+1]).normalizeInRange(normalizedDistance))
    }
    
    func findBounds(for normalizedDistance: Double) -> (Int, Double) {
        return findBoundsNormalized(for: normalizedDistance, index: findBounds(for: normalizedDistance, index: 0))
    }
    
    private func useLinear(index: Int, _ t: Double) -> CGPoint {
        assert(index >= 0 && index < self.count)
        assert(t >= 0 && t <= 1)
        return CGPoint.lerp(self[index], self[index+1], t)
    }
    
    func redistribute(step: Double) -> Stroke {
        let newCount = Int(round(self.strokeLength() / step))
        
        var result: Stroke = .init()
        
        for p in 0..<newCount {
            let boundsForP = self.findBounds(for: Double(p) / Double(newCount - 1))
            result.append(self.useLinear(index: boundsForP.0, boundsForP.1))
        }
        
        return result
    }
}
