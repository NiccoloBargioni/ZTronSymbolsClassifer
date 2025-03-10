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
        
        let scaleX = bbWidth == 0 ? 1.0 : targetWidth / bbWidth
        let scaleY = bbHeight == 0 ? 1.0 : targetHeight / bbHeight
        let transX = bbWidth == 0 ? rect.origin.x + 0.5 * targetWidth : rect.origin.x
        let transY = bbHeight == 0 ? rect.origin.y + 0.5 * targetHeight : rect.origin.y
        
        return self.map { (CGPoint(x: scaleX * ($0.x - bbMin.x), y: scaleY * ($0.y - bbMin.y))) + CGPoint(x: transX, y: transY) }
    }
    
    /// Computes the total stroke length, defined as the sum of the length of vectors joining two consecutive points in the stroke. A stroke that contains less than two points is defined to be of length zero.
    func strokeLength() -> Double {
        guard self.count > 1 else { return 0 }
        return zip(self, self.dropFirst()).reduce(0) { $0 + $1.0.euclideanDistance(to: $1.1) }
    }
        
    /// Redistribute the points along the stroke using linear interpolation to ensure that it's made of `num` points, approximately evenly spaced, in a way that it preserves the stroke's first and last point.
    ///
    /// - Complexity: O(self.count)
    func redistribute(_ num: Int) -> Stroke {
        guard num > 0, self.count > 0 else { return [] }
        
        if num == 1 {
            if let first = self.first {
                return [first]
            }
        }
        
        let dist = self.strokeLength() / Double(num)
        return self.redistribute(step: dist)
    }
    
    /// fit the first rect maximally and centered into the second rect keeping the aspect ratio
    func aspectFit(source: CGRect, target: CGRect) -> CGRect {
        let sourceRatio = source.width / source.height;
        let targetRatio = target.width / target.height;
        
        let sourceWider = sourceRatio > targetRatio;
        
        let scaleFactor = sourceWider ? target.width / source.width : target.height / source.height;
        
        let offset: CGPoint = sourceWider ? CGPoint(
            x: 0,
            y: (target.height - scaleFactor * source.height) / 2.0
        ) : CGPoint(
            x: (target.width - scaleFactor * source.width) / 2.0,
            y: 0
        )

        let newOrigin = target.origin + offset
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
    

    private func angle(_ x: CGPoint, _ y: CGPoint, _ z: CGPoint) -> Double {
        let v = CGPoint(x: y.x - x.x, y: y.y - x.y)
        let w = CGPoint(x: z.x - y.x, y: z.y - y.y)
        
        let dotProduct = v.dot(w)
        let normProduct = v.norm() * w.norm()
        
        return acos((-1.0..<1.0).clamp(dotProduct / normProduct))
    }
    
    /// Simplifies the stroke by removing points that don't significatively contribute to the shape of the stroke, based on an angle threshold.
    func dominant(_ alpha: Double) -> Stroke {
        guard self.count > 2 else { return self }
        
        var result: Stroke = [self[0]]
        
        var i = 1
        while i < self.count - 1 {
            let a = self[i - 1]
            let b = self[i]
            let c = self[i + 1]
            
            if angle(a, b, c) < alpha {
                i += 1
            } else {
                result.append(b)
                i += 1
            }
        }
        
        result.append(self.last!)
        return result
    }
}


public extension Strokes {
    func sanitize() -> Strokes {
        var sanitized: Strokes = .init()
        let alpha = 2 * Double.pi * 15 / 360.0;
        
        for i in 0..<self.count {
            let processedStroke =
                self[i]
                    .unduplicate()
                    .redistribute(10)
                    .aspectRefit(
                        in: .init(
                            origin: .zero,
                            size: .init(
                                width: 1.0,
                                height: 1.0
                            )
                        )
                    )
                    .smooth()
                    .unduplicate()
                    .dominant(alpha)
            
            sanitized.append(processedStroke)
        }
        
        return Strokes(sanitized.prefix(10))
    }
}
