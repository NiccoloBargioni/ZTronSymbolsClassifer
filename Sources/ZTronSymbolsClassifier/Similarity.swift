infix operator ~~ : ComparisonPrecedence
infix operator /~ : ComparisonPrecedence
infix operator <~ : ComparisonPrecedence
infix operator >~ : ComparisonPrecedence

protocol Sim {
    static func ~~ (lhs: Self, rhs: Self) -> Bool
    static func /~ (lhs: Self, rhs: Self) -> Bool
}

extension Sim {
    static func /~ (lhs: Self, rhs: Self) -> Bool {
        return !(lhs ~~ rhs)
    }
    
    static func ~~ (lhs: Self, rhs: Self) -> Bool {
        return !(lhs /~ rhs)
    }
}


protocol Simord: Sim, Comparable {
    static func <~ (lhs: Self, rhs: Self) -> Bool
    static func >~ (lhs: Self, rhs: Self) -> Bool
}


extension Simord {
    static func <~ (lhs: Self, rhs: Self) -> Bool {
        return lhs < rhs || lhs ~~ rhs
    }
    
    static func >~ (lhs: Self, rhs: Self) -> Bool {
        return lhs > rhs || lhs ~~ rhs
    }
}
