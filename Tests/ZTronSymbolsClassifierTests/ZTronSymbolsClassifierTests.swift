import XCTest
@testable import ZTronSymbolsClassifier
import CoreGraphics

fileprivate let redistributeTestStroke = [
    [
        CGPoint(x: -10.76, y: 16.17),
        CGPoint(x: -11.46, y: 1.22),
        CGPoint(x: -4, y: 1.12),
        CGPoint(x: -6.28, y: 2.66),
        CGPoint(x: 3.43, y: 3.1),
        CGPoint(x: -7.3, y: 10.75),
    ]
]

fileprivate let A1 = [
    [
        CGPoint(x: 0.43969220226625244, y: 0.06298968830075007),
        CGPoint(x: 0.5569049088708972, y: 0.05978739140200867),
        CGPoint(x: 0.6064903266534776, y: 0.12985781799025012),
        CGPoint(x: 0.5820458031811907, y: 0.2703364317821984),
        CGPoint(x: 0.37584416000860127, y: 0.7314760555144671),
        CGPoint(x: 0.39342686458324944, y: 0.8753362860180269),
        CGPoint(x: 0.47531225611326783, y: 0.9465907464758354),
        CGPoint(x: 0.6083586206550768, y: 0.9433455242590257)
    ],

    [
        CGPoint(x: 0.42890042866956574, y: 0.0014449045714602722),
        CGPoint(x: 0.5252662185311187, y: 0.052010360521593225),
        CGPoint(x: 0.5539256177720437, y: 0.15377353007292935),
        CGPoint(x: 0.3620613179806847, y: 0.7631195994696469),
        CGPoint(x: 0.40737032797279377, y: 0.8952241268545764),
        CGPoint(x: 0.5142521182616395, y: 0.955002023126707),
        CGPoint(x: 0.6603226854332687, y: 0.9423168725422343)
    ]
]

fileprivate let A2 = [
    [
        CGPoint(x: 0.21394408140405102, y: 0.032025793696644204),
        CGPoint(x: 0.3617050069765721, y: 0.03936343696196337),
        CGPoint(x: 0.4645557579795829, y: 0.11231150578524625),
        CGPoint(x: 0.5057592982849501, y: 0.2506900230102686),
        CGPoint(x: 0.47033245436695625, y: 0.7416285957169904),
        CGPoint(x: 0.5296937609453193, y: 0.8807043472550745),
        CGPoint(x: 0.6417123468804874, y: 0.9652630556769783),
        CGPoint(x: 0.786055918595949, y: 0.9999999999999999),
    ],

    [
        CGPoint(x: 0.16207295528484528, y: 0.0),
        CGPoint(x: 0.31151207211190274, y: 0.04097283496399657),
        CGPoint(x: 0.4024653544861542, y: 0.13619094366567838),
        CGPoint(x: 0.4874570572144575, y: 0.788698613822259),
        CGPoint(x: 0.5802067073842018, y: 0.9121983298180467),
        CGPoint(x: 0.7006108032990742, y: 0.945470489283379),
        CGPoint(x: 0.8379270447151548, y: 0.8932036267274622),
    ]
]

fileprivate let A3 = [
    [
        CGPoint(x: 0.5479471755268358, y: 0.0),
        CGPoint(x: 0.6299728719868084, y: 0.07745657723675509),
        CGPoint(x: 0.6512985401092366, y: 0.18205239075083587),
        CGPoint(x: 0.37007595566265694, y: 0.8229517893206005),
        CGPoint(x: 0.37249740355560074, y: 0.9242816392055611),
        CGPoint(x: 0.43423517162742714, y: 0.9999999999999999),
    ],
    [
        CGPoint(x: 0.4832394080095563, y: 0.0),
        CGPoint(x: 0.5988110104268468, y: 0.06711038071825363),
        CGPoint(x: 0.6462194653865556, y: 0.17461026707355173),
        CGPoint(x: 0.6122826933284021, y: 0.316767789224562),
        CGPoint(x: 0.38189988321790574, y: 0.7369270484040339),
        CGPoint(x: 0.3609208915205455, y: 0.8727089670176754),
        CGPoint(x: 0.4128647522441953, y: 0.9460812785665635),
        CGPoint(x: 0.5293846625497475, y: 0.9535379148088334),
    ],
]

fileprivate let N1 = [
    [
        CGPoint(x: 0.0, y: 0.7141763022072605),
        CGPoint(x: 0.47372333008689277, y: 0.426332288294893),
        CGPoint(x: 0.68167860620151, y: 0.3779119584675652),
        CGPoint(x: 0.8557947539107529, y: 0.45473535095504386),
        CGPoint(x: 0.896037155366467, y: 0.6032585901683192),
        CGPoint(x: 0.7933461906244333, y: 0.6956860025908403),
        CGPoint(x: 0.060396350999708824, y: 0.6890224349884373),
    ],

    [
        CGPoint(x: 0.5193825735942407, y: 0.0),
        CGPoint(x: 0.4900908847702925, y: 0.9320535776837312),
        CGPoint(x: 0.5094733068415083, y: 1.0),
    ],

    [
        CGPoint(x: 0.3607940657258526, y: 0.0),
        CGPoint(x: 0.6392059342741474, y: 0.9999999999999999),
    ]
]

fileprivate let N2 = [
    [
        CGPoint(x: 0.00971792137709574, y: 0.6516071594699913),
        CGPoint(x: 0.40744846549116237, y: 0.42227586033888714),
        CGPoint(x: 0.6096502072581004, y: 0.43051502933154934),
        CGPoint(x: 0.8080401651311595, y: 0.5253600716464342),
        CGPoint(x: 0.8568054214954756, y: 0.6011168183073293),
        CGPoint(x: 0.7497359077708047, y: 0.6360407596285975),
        CGPoint(x: 0.0, y: 0.6403991491290009),
    ],

    [
        CGPoint(x: 0.506438619760016, y: 0.0),
        CGPoint(x: 0.4635150119947982, y: 1.0),
    ],

    [
        CGPoint(x: 0.48757798232396093, y: 0.0),
        CGPoint(x: 0.49751564195544096, y: 1.0),
    ]
]

fileprivate let N3 = [
    [
        CGPoint(x: 0.0, y: 0.612333754309569),
        CGPoint(x: 0.41583163526030736, y: 0.38925217218669667),
        CGPoint(x: 0.6121744979406963, y: 0.400236238211405),
        CGPoint(x: 0.8052167588500504, y: 0.5129296671982205),
        CGPoint(x: 0.8512935994802953, y: 0.6095244965719273),
        CGPoint(x: 0.7474824937266981, y: 0.6448365763421698),
        CGPoint(x: 0.003986554570014361, y: 0.5993066018447937),
    ],

    [
        CGPoint(x: 0.7107756220823161, y: 0.0),
        CGPoint(x: 0.28922437791768385, y: 1.0),
    ],

    [
        CGPoint(x: 0.5481127800015861, y: 0.0),
        CGPoint(x: 0.4518872199984139, y: 0.9999999999999999),
    ]
]

fileprivate extension CGRect {
    static func isValidBox(originX: CGFloat, originY: CGFloat, bottomTrailingX: CGFloat, bottomTrailingY: CGFloat) -> Bool {
        return originX < bottomTrailingX && originY < bottomTrailingY
    }
    
    init(origin: CGPoint, bottomTrailing: CGPoint) {
        self.init(
            origin: origin,
            size: .init(width: abs(bottomTrailing.x - origin.x), height: abs(bottomTrailing.y - origin.y))
        )
    }
}

fileprivate extension CGPoint {
    func isInside(rect: CGRect) -> Bool {
        return (self.x >= rect.origin.x && self.x <= rect.bottomRight().x && self.y >= rect.origin.y && self.y <= rect.bottomRight().y)
    }
}


final class SomeTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    @MainActor func test_prop_stroke_fits_inside_bounding_box() throws {
        guard !A1.isEmpty else { return }
        
        for stroke in A1 {
            let bbox = stroke.boundingBox()

            for point in stroke {
                XCTAssertTrue(point.isInside(rect: bbox))
            }
        }
   }
    
    @MainActor func test_prop_refit_into_boundingbox_is_identity() throws {
        guard A1.count > 0 else { return }

        for stroke in A1 {
            let strokeBoundingBox = stroke.boundingBox()
            let refitted = stroke.refit(strokeBoundingBox)
            
            XCTAssertEqual(refitted.count, stroke.count)
            
            for i in 0..<refitted.count {
                XCTAssertEqual(refitted[i].x, stroke[i].x)
                XCTAssertEqual(refitted[i].y, stroke[i].y)
            }
        }
    }
    
    
    @MainActor func test_prop_refit_fits_inside() throws {
        let normalAABB = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        guard A1.count > 0 && CGRect.isValidBox(originX: 0.0, originY: 0.0, bottomTrailingX: 1.0, bottomTrailingY: 1.0) else { return }
        
        for stroke in A1 {
            let refitted = stroke.refit(normalAABB)
            
            for point in refitted {
                XCTAssertTrue(point.isInside(rect: normalAABB))
            }
        }
    }
    
    @MainActor func test_prop_refit_idempotent() throws {
        let normalAABB = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        guard A1.count > 0 && CGRect.isValidBox(originX: 0.0, originY: 0.0, bottomTrailingX: 1.0, bottomTrailingY: 1.0) else { return }

        for stroke in A1 {
            let refittedStroke = stroke.refit(normalAABB)
            let refittedRefittedStroke = refittedStroke.refit(normalAABB)
            
            XCTAssertEqual(refittedStroke.count, refittedRefittedStroke.count)
            
            for i in 0..<refittedStroke.count {
                XCTAssertEqual(refittedStroke[i].x, refittedRefittedStroke[i].x)
                XCTAssertEqual(refittedStroke[i].y, refittedRefittedStroke[i].y)
            }
        }
    }
    
    @MainActor func test_prop_redistdribute_preserves_first_point() throws {
        for stroke in A1 {
            if let firstPointInStroke = stroke.first {
                let redistributeStroke = stroke.redistribute(150)
                                
                if let firstRedistributedPoint = redistributeStroke.first {
                    XCTAssertEqual(firstPointInStroke.x, firstRedistributedPoint.x)
                    XCTAssertEqual(firstPointInStroke.y, firstRedistributedPoint.y)
                }
            }
        }
    }
    
    @MainActor func test_prop_redistdribute_preserves_last_point() throws {
        for stroke in A1 {
            if let lastPointInStroke = stroke.last {
                let redistributeStroke = stroke.redistribute(5)
                
                if let lastRedistributedPoint = redistributeStroke.last {
                    XCTAssertEqual(lastPointInStroke.x, lastRedistributedPoint.x)
                    XCTAssertEqual(lastPointInStroke.y, lastRedistributedPoint.y)
                }
            }
        }
    }
    
    @MainActor func test_prop_smooth_preserves_count() throws {
        for stroke in A1 {
            let smoothed = stroke.smooth()
            XCTAssertEqual(smoothed.count, stroke.count)
            XCTAssertEqual(smoothed.first, stroke.first)
            XCTAssertEqual(smoothed.last, stroke.last)
        }
    }
    
    @MainActor func test_stroke_refit() throws {
        let refitted = A1.map { stroke in
            return stroke.refit(.init(origin: .zero, size: .init(width: 1.0, height: 1.0)))
        }
        
        for stroke in refitted {
            for point in stroke {
                XCTAssert(point.x >= 0 && point.x <= 1)
                XCTAssert(point.y >= 0 && point.y <= 1)
            }
        }
    }
    
    @MainActor func test_vector_norm() throws {
        let x: Double = Double.random(in: 0...1)
        let y: Double = Double.random(in: 0...1)
        
        let someRandomPoint = CGPoint(x: x, y: y)
        
        let estimatedNorm = sqrt(x*x + y*y)
        XCTAssertEqual(estimatedNorm, someRandomPoint.norm())
    }
    
    @MainActor func test_vector_operations() throws {
        let x1: Double = Double.random(in: 0...1)
        let y1: Double = Double.random(in: 0...1)
        
        let x2: Double = Double.random(in: 0...1)
        let y2: Double = Double.random(in: 0...1)
        
        let someV1 = CGPoint(x: x1, y: y1)
        let someV2 = CGPoint(x: x2, y: y2)
        
        let totalLength: Double = A1.first!.strokeLength() / 9.0
        let left: Double = totalLength / 2.0
        
        let someRandomPoint = A1.first!.randomElement()!
        
        let dir = someV2 - someV1
        
        let previousPoint = CGPoint(
            x: totalLength/left * dir.x + someRandomPoint.x,
            y: totalLength/left * dir.y + someRandomPoint.y
        )
        
        XCTAssertEqual((dir + previousPoint).x, dir.x + previousPoint.x)
        XCTAssertEqual((dir + previousPoint).y, dir.y + previousPoint.y)
        
        XCTAssertEqual((left * dir).x, left * dir.x)
        XCTAssertEqual((left * dir).y, left * dir.y)
        
        XCTAssertEqual(previousPoint.x, (((totalLength/left) * dir) + someRandomPoint).x)
        XCTAssertEqual(previousPoint.y, (((totalLength/left) * dir) + someRandomPoint).y)
    }
    
    @MainActor func test_stroke_aspectFit() throws {
        let refitted = A1.map { stroke in
            let boundingBox = stroke.boundingBox()
            return stroke.aspectFit(source: stroke.boundingBox(), target: .init(origin: .zero, size: .init(width: 1.0, height: 1.0)))
        }
        
        for boundingBox in refitted {
            assert(boundingBox.origin.x >= 0 && boundingBox.origin.x <= 1)
            assert(boundingBox.origin.y >= 0 && boundingBox.origin.y <= 1)
            assert(boundingBox.width >= 0 && boundingBox.width <= 1)
            assert(boundingBox.height >= 0 && boundingBox.height <= 1)
        }
    }
    
    @MainActor func test_stroke_aspectRefit() throws {
        let refitted = A1.map { stroke in
            return stroke.aspectRefit(in: .init(origin: .zero, size: .init(width: 1.0, height: 1.0)))
        }
        
        for stroke in refitted {
            for point in stroke {
                assert(point.x >= 0 && point.x <= 1)
                assert(point.y >= 0 && point.y <= 1)
            }
        }
    }
    
    @MainActor func test_stroke_length() throws {
        for stroke in redistributeTestStroke {
            var theLength = 0.0
            for i in 0..<stroke.count-1 {
                theLength += sqrt((stroke[i+1].x - stroke[i].x)*(stroke[i+1].x - stroke[i].x) + (stroke[i+1].y - stroke[i].y)*(stroke[i+1].y - stroke[i].y))
            }
            
            XCTAssertEqual(theLength, stroke.strokeLength())
        }
    }
    
    @MainActor func test_stroke_redistribute() throws {
        for stroke in A1 {
            let redistributed = stroke.redistribute(step: stroke.strokeLength() / 9.0)
            let redistributedAlt = stroke.redistribute(9)
                    
            XCTAssertEqual(redistributed.count, 9)
            XCTAssertEqual(redistributedAlt.count, 9)
        }
    }
    
    @MainActor func testNormalizedDistances() throws {
        for stroke in redistributeTestStroke {
            let normalized = stroke.normalizedDistances()
            XCTAssertEqual(normalized.first, 0)
            XCTAssertEqual(normalized.last, 1)
            XCTAssertEqual(normalized.count, stroke.count)
        }
    }
    
    @MainActor func test_stroke_sanification() throws {
        let sanitised = N3.sanitize()
        
        for stroke in sanitised {
            XCTAssertLessThanOrEqual(stroke.count, 10)
            
            print(stroke.toCGString())
            
            for point in stroke {
                assert(point.x >= 0 && point.x <= 1)
                assert(point.y >= 0 && point.y <= 1)
            }
        }
    }
    
    @MainActor func test_classifier_training() throws {
        let alphabetClassifier = Classifier<Alphabet>(samplelimit: Int.max - 1)
        
        let test = StrokeSample(strokes: A2)
        
        alphabetClassifier.train(identifier: .A, sample: StrokeSample(strokes: A1))
        alphabetClassifier.train(identifier: .A, sample: StrokeSample(strokes: A3))
        alphabetClassifier.train(identifier: .N, sample: StrokeSample(strokes: N1))
        alphabetClassifier.train(identifier: .N, sample: StrokeSample(strokes: N3))
        
        let result = alphabetClassifier.classify(sampleType: StrokeSample.self, unknown: test)
        
        for hit in result {
            print(hit.score, hit.identifier)
        }
    }
    
    
}


fileprivate enum Alphabet: Hashable {
    case A
    case B
    case C
    case D
    case E
    case F
    case G
    case H
    case I
    case J
    case K
    case L
    case M
    case N
    case O
    case P
    case Q
    case R
    case S
    case T
    case U
    case V
    case W
    case X
    case Y
    case Z
}
