import Foundation

protocol Sample {
    func distance(_ a: any Sample, _ b: any Sample) -> Double
    func distanceLowerBound(_ a: any Sample, _ b: any Sample) -> Double
}

struct Hit {
    let samplescore: Double
    let sample: any Sample
}

struct Score: Comparable {
    let identifier: String
    let score: Double
    
    static func < (lhs: Score, rhs: Score) -> Bool {
        return lhs.score < rhs.score
    }
}

class SampleEntry {
    let identifier: String
    var samples: [any Sample]
    
    init(identifier: String, sample: any Sample) {
        self.identifier = identifier
        self.samples = [sample]
    }
}

class Classifier {
    let samplelimit: Int
    private var entries: [SampleEntry]
    private let lock = DispatchQueue(label: "classifier.lock")
    
    init(samplelimit: Int) {
        self.samplelimit = samplelimit
        self.entries = []
    }
    
    func train(identifier: String, sample: any Sample) {
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
    
    func classify(sampleType: any Sample, unknown: any Sample) -> [Score] {
        return lock.sync {
            var results: [Score] = []
            
            for entry in entries {
                let distances = entry.samples.map { sampleType.distance(unknown, $0) }.sorted()
                let meanMin = distances.prefix(2).reduce(0, +) / Double(min(2, distances.count))
                results.append(Score(identifier: entry.identifier, score: meanMin))
            }
            
            return results.sorted()
        }
    }
}
