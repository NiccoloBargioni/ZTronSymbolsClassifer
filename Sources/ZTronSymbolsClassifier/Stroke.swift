import Foundation

public typealias Stroke = [CGPoint]
public typealias Strokes = [Stroke]


extension Stroke {
    /// Computes the smallest rectangle that contains all the points in this stroke.
    ///
    /// - Complexity: Time: O(self.count)
    func boundingBox() -> CGRect {
        guard let first = self.first else { fatalError("Empty stroke has no bounding box") }
        let mainDiagonal = self.reduce((first, first)) { (current, point) in
            let (minPoint, maxPoint) = current
            return (
                CGPoint(x: Swift.min(minPoint.x, point.x), y: Swift.min(minPoint.y, point.y)),
                CGPoint(x: Swift.max(maxPoint.x, point.x), y: Swift.max(maxPoint.y, point.y))
            )
        }
        
        assert(mainDiagonal.1.x >= mainDiagonal.0.x)
        assert(mainDiagonal.1.y >= mainDiagonal.0.y)
        
        return CGRect(
            origin: mainDiagonal.0,
            size: .init(
                width: mainDiagonal.1.x - mainDiagonal.0.x,
                height: mainDiagonal.1.y - mainDiagonal.0.y
            )
        )
    }
    
    /// Refit, i.e. scale and translate `self`, so that it fits inside `rect`. To be used for normalisation purposes.
    ///
    /// - Parameter rect: The rectangle to fit this stroke in.
    ///
    /// - Complexity: Time: O(self.count), Space: O(1)
    func refit(_ rect: CGRect) -> Stroke {
        guard rect.origin.x <= rect.bottomRight().x && rect.origin.y <= rect.bottomRight().y else { fatalError("Invalid rect dimensions") }
        guard !self.isEmpty else { return [] }
        
        let bbMin = self.boundingBox().origin
        let bbMax = self.boundingBox().bottomRight()
        
        
        let bbWidth = bbMax.x - bbMin.x
        let bbHeight = bbMax.y - bbMin.y
        let targetWidth = rect.bottomRight().x - rect.origin.x
        let targetHeight = rect.bottomRight().y - rect.origin.y
        
        let scaleX = bbWidth == 0 ? 1 : targetWidth / bbWidth
        let scaleY = bbHeight == 0 ? 1 : targetHeight / bbHeight
        let transX = bbWidth == 0 ? rect.origin.x + 0.5 * targetWidth : rect.origin.x
        let transY = bbHeight == 0 ? rect.origin.y + 0.5 * targetHeight : rect.origin.y
        
        return self.map { (CGPoint(x: scaleX * ($0.x - bbMin.x), y: scaleY * ($0.y - bbMin.y))) + CGPoint(x: transX, y: transY) }
    }
    
    /// Computes the total stroke length, defined as the sum of the length of vectors joining two consecutive points in the stroke. A stroke that contains less than two points is defined to be of length zero.
    func strokeLength() -> Double {
        guard self.count > 1 else { return 0 }
        return zip(self, self.dropFirst()).reduce(0) { $0 + $1.0.euclideanDistance(to: $1.1) }
    }
    
    func redistribute(distance: Double) -> Stroke {
        guard distance > 0 else { return [] }
        guard self.count > 1 else { return self }
        guard let firstPoint = self.first else { return [] }
        
        var index = 1
        var result = Stroke.init(arrayLiteral: firstPoint)
        
        var left = distance
        
        while index < self.count {
            if let previousPoint = result.last {
                let nextPoint = self[index]
                let consecutivePointsDistance = previousPoint.euclideanDistance(to: nextPoint)
                
                if consecutivePointsDistance < left {
                    left -= consecutivePointsDistance
                    index += 1
                } else {
                    let ratio = left / consecutivePointsDistance
                    let adjustedNextPoint = previousPoint + ratio * (nextPoint - previousPoint)
                    result.append(adjustedNextPoint)
                    left = distance
                }

            }
        }
        
        if let lastPoint = self.last {
            result.append(lastPoint)
        }
        
        return result
    }
    
    /// Redistribute the points along the stroke using linear interpolation to ensure that it's made of `num` points, approximately evenly spaced.
    ///
    /// - Complexity: O(self.count)
    func redistribute(_ num: Int) -> Stroke {
        guard num > 0, self.count > 0 else { return [] }
        
        if num == 1 {
            if let first = self.first {
                return [first]
            }
        }
        
        let dist = self.strokeLength() / Double(num - 1)
        return self.redistribute(distance: dist)
    }
    
    /// fit the first rect maximally and centered into the second rect keeping the aspect ratio
    func aspectFit(source: CGRect, target: CGRect) -> CGRect {
        let sourceRatio = source.width / source.height;
        let targetRatio = target.width / target.height;
        
        let sourceWider = sourceRatio > targetRatio;
        
        let scaleFactor = sourceWider ? target.width / source.width : target.height / source.height;
        
        let offset: CGPoint = sourceWider ? CGPoint(
            x: 0,
            y: (target.height - scaleFactor * source.height)/2.0
        ) : CGPoint(
            x: (target.width - scaleFactor * source.width) / 2.0,
            y: 0
        )
        
        let newOrigin = scaleFactor * source.origin + offset + target.origin
        return CGRect(
            origin: newOrigin,
            size: .init(
                width: source.width * scaleFactor,
                height: source.height * scaleFactor
            )
        )
    }
    
    
    func aspectRefit(in rect: CGRect) -> Stroke {
        return self.refit(self.aspectFit(source: self.boundingBox(), target: rect))
    }
    
    
    func unduplicate() -> Stroke {
        guard !self.isEmpty else { return self }
        
        var result: [CGPoint] = [self[0]]
        
        for i in 1..<self.count {
            if self[i] /~ self[i - 1] {
                result.append(self[i])
            }
        }
        
        return result
    }
    

    func smooth() -> Stroke {
        guard self.count >= 3 else { return self }
        var smoothed: Stroke = .init()
        
        smoothed.append(self[0])
        
        for i in 0..<(self.count - 2) {
            smoothed.append(
                CGPoint(
                    x: (self[i].x + self[i+1].x + self[i+2].x)/3.0,
                    y: (self[i].y + self[i+1].y + self[i+2].y)/3.0
                )
            )
        }
        
        smoothed.append(self[self.count - 1])
        
        return smoothed
    }
    
    
    private func fixDomain(value: Double) -> Double {
        return Swift.min(1.0, Swift.max(-1.0, value));
    }
    
    private func angle(_ x: CGPoint, _ y: CGPoint, _ z: CGPoint) -> Double {
        let v = CGPoint(x: y.x - x.x, y: y.y - x.y)
        let w = CGPoint(x: z.x - y.x, y: z.y - y.y)
        
        let dotProduct = v.dot(w)
        let normProduct = v.norm() * w.norm()
        
        return acos(fixDomain(value: dotProduct / normProduct))
    }
    
    func dominant(_ alpha: Double, _ stroke: Stroke) -> Stroke {
        guard stroke.count > 2 else { return stroke }
        
        var result: Stroke = [stroke[0]]
        
        var i = 1
        while i < stroke.count - 1 {
            let a = stroke[i - 1]
            let b = stroke[i]
            let c = stroke[i + 1]
            
            if angle(a, b, c) < alpha {
                i += 1
            } else {
                result.append(b)
                i += 1
            }
        }
        
        result.append(stroke.last!)
        return result
    }

}



