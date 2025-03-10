import Foundation

public protocol Sample {
    static func distance(_ a: any Sample, _ b: any Sample) -> Double
    static func distanceLowerBound(_ a: any Sample, _ b: any Sample) -> Double
}

public struct Score<ID: Hashable>: Comparable {
    let identifier: ID
    let score: Double
    
    public init(identifier: ID, score: Double) {
        self.identifier = identifier
        self.score = score
    }
    
    public static func < (lhs: Score, rhs: Score) -> Bool {
        return lhs.score < rhs.score
    }
}

class SampleEntry<ID: Hashable> {
    let identifier: ID
    var samples: [any Sample]
    
    init(identifier: ID, sample: any Sample) {
        self.identifier = identifier
        self.samples = [sample]
    }
}

public final class Classifier<ID: Hashable> {
    let samplelimit: Int
    private var entries: [SampleEntry<ID>]
    private let lock = DispatchQueue(label: "classifier.lock")
    
    public init(samplelimit: Int) {
        self.samplelimit = samplelimit
        self.entries = []
    }
    
    public func train(identifier: ID, sample: any Sample) {
        lock.sync {
            if let entry = entries.first(where: { $0.identifier == identifier }) {
                if entry.samples.count < samplelimit {
                    entry.samples.append(sample)
                } else {
                    entry.samples.removeFirst()
                    entry.samples.append(sample)
                }
            } else {
                let newEntry = SampleEntry(identifier: identifier, sample: sample)
                entries.append(newEntry)
            }
        }
    }
    
    public func classify<T: Sample>(sampleType: T.Type, unknown: any Sample) -> [Score<ID>] {
        return lock.sync {
            var results: [Score<ID>] = []
            
            for entry in entries {
                let distances = entry.samples.map { T.distance(unknown, $0) }.sorted()
                let meanMin = distances.prefix(2).reduce(0, +) / Double(min(2, distances.count))
                results.append(Score(identifier: entry.identifier, score: meanMin))
            }
            
            return results.sorted()
        }
    }
}
