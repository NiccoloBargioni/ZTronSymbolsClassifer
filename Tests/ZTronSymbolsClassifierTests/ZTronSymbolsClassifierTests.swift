import XCTest
@testable import ZTronSymbolsClassifier
import CoreGraphics

fileprivate let randomStoke = [
    [
        CGPoint(x: 0.20232171205738883, y: 0.297323600973236),
        CGPoint(x: 0.20232171205738883, y: 0.29440389294403896),
        CGPoint(x: 0.20232171205738883, y: 0.29148418491484185),
        CGPoint(x: 0.20315088680134483, y: 0.28905108746530944),
        CGPoint(x: 0.20563844899039957, y: 0.2861313794361124),
        CGPoint(x: 0.208955223880597, y: 0.28418491484184916),
        CGPoint(x: 0.2180762599356732, y: 0.2802919633777182),
        CGPoint(x: 0.22305138431378266, y: 0.2788321093631197),
        CGPoint(x: 0.23963514489320972, y: 0.27737225534852117),
        CGPoint(x: 0.2470978314603739, y: 0.27688564476885646),
        CGPoint(x: 0.24958539364942864, y: 0.27688564476885646),
        CGPoint(x: 0.2512437810945274, y: 0.27688564476885646),
        CGPoint(x: 0.2529021305824394, y: 0.27737225534852117),
        CGPoint(x: 0.2570480802165928, y: 0.278345498783455),
        CGPoint(x: 0.26616915422885573, y: 0.28175181739231675),
        CGPoint(x: 0.2678275037167677, y: 0.28321167140691533),
        CGPoint(x: 0.26948589116186644, y: 0.28515813600117856),
        CGPoint(x: 0.27114427860696516, y: 0.2875912334507109),
        CGPoint(x: 0.27197345335092116, y: 0.2900243309002433),
        CGPoint(x: 0.2736318407960199, y: 0.2929440389294404),
        CGPoint(x: 0.2736318407960199, y: 0.30170316301703165),
        CGPoint(x: 0.27280262809487715, y: 0.30656933564049194),
        CGPoint(x: 0.27197345335092116, y: 0.3119221411192214),
        CGPoint(x: 0.27114427860696516, y: 0.31824816775728026),
        CGPoint(x: 0.26948589116186644, y: 0.32457419439533913),
        CGPoint(x: 0.2669983289728117, y: 0.3313868538886671),
        CGPoint(x: 0.2628523793386583, y: 0.3386861239616598),
        CGPoint(x: 0.2553896927714941, y: 0.3557177615571776),
        CGPoint(x: 0.2512437810945274, y: 0.3639902527894997),
        CGPoint(x: 0.24792700620432992, y: 0.37177615571776157),
        CGPoint(x: 0.24295188182622046, y: 0.38004864695008367),
        CGPoint(x: 0.237147582704155, y: 0.38929440389294406),
        CGPoint(x: 0.23217245832604555, y: 0.3980535279805353),
        CGPoint(x: 0.21890547263681592, y: 0.42141119221411194),
        CGPoint(x: 0.21061357336850903, y: 0.4345498783454988),
        CGPoint(x: 0.20315088680134483, y: 0.4467153210419518),
        CGPoint(x: 0.19568820023418065, y: 0.46034061775300333),
        CGPoint(x: 0.18407960199004975, y: 0.490510941479908),
        CGPoint(x: 0.1791044776119403, y: 0.5070559462201566),
        CGPoint(x: 0.17412935323383083, y: 0.5255474378302729),
        CGPoint(x: 0.1699834035996774, y: 0.5440389294403893),
        CGPoint(x: 0.1699834035996774, y: 0.5605839341806379),
        CGPoint(x: 0.17412935323383083, y: 0.5742092308916895),
        CGPoint(x: 0.18242121454495103, y: 0.5863746958637469),
        CGPoint(x: 0.19568820023418065, y: 0.5956204305310029),
        CGPoint(x: 0.22553894650283737, y: 0.6058394086331926),
        CGPoint(x: 0.24295188182622046, y: 0.6019464571690617),
        CGPoint(x: 0.24958539364942864, y: 0.5931873330814705),
        CGPoint(x: 0.2570480802165928, y: 0.5829683549792807),
    ],
    [
        CGPoint(x: 0.3333333333333333, y: 0.2909975520595727),
        CGPoint(x: 0.3333333333333333, y: 0.2880778440303756),
        CGPoint(x: 0.3333333333333333, y: 0.2871046228710462),
        CGPoint(x: 0.3341625080772893, y: 0.2856447688564477),
        CGPoint(x: 0.33582089552238803, y: 0.28467152542151386),
        CGPoint(x: 0.3366500702663441, y: 0.28418491484184916),
        CGPoint(x: 0.3399668071993548, y: 0.28272506082725063),
        CGPoint(x: 0.3424543693884095, y: 0.28223842797198145),
        CGPoint(x: 0.34328358208955223, y: 0.28175181739231675),
        CGPoint(x: 0.3441127568335082, y: 0.28175181739231675),
        CGPoint(x: 0.3449419315774642, y: 0.28175181739231675),
        CGPoint(x: 0.34577114427860695, y: 0.28175181739231675),
        CGPoint(x: 0.3524046181446284, y: 0.28175181739231675),
        CGPoint(x: 0.35489218033368314, y: 0.28223842797198145),
        CGPoint(x: 0.3590381299678366, y: 0.28321167140691533),
        CGPoint(x: 0.36318407960199006, y: 0.28418491484184916),
        CGPoint(x: 0.3656716417910448, y: 0.28515813600117856),
        CGPoint(x: 0.3681592039800995, y: 0.2866179900157771),
        CGPoint(x: 0.373963503102165, y: 0.2900243309002433),
        CGPoint(x: 0.3764510652912197, y: 0.29148418491484185),
        CGPoint(x: 0.3781094527363184, y: 0.2934306495091051),
        CGPoint(x: 0.3797678022242304, y: 0.2948905035237036),
        CGPoint(x: 0.3805970149253731, y: 0.29683696811796684),
        CGPoint(x: 0.3805970149253731, y: 0.2982968221325654),
        CGPoint(x: 0.3814261896693291, y: 0.29975667614716395),
        CGPoint(x: 0.3814261896693291, y: 0.3046228710462287),
        CGPoint(x: 0.3814261896693291, y: 0.3075425790754258),
        CGPoint(x: 0.3814261896693291, y: 0.3109488976842876),
        CGPoint(x: 0.3814261896693291, y: 0.3148418491484185),
        CGPoint(x: 0.3814261896693291, y: 0.31873477833694497),
        CGPoint(x: 0.3814261896693291, y: 0.3226277298010759),
        CGPoint(x: 0.3789386274802744, y: 0.3309002433090024),
        CGPoint(x: 0.3781094527363184, y: 0.33527980535279805),
        CGPoint(x: 0.3772802400351757, y: 0.33819951338199516),
        CGPoint(x: 0.3756218905472637, y: 0.3420924425705216),
        CGPoint(x: 0.37479267784612097, y: 0.3450121505997187),
        CGPoint(x: 0.3731343283582089, y: 0.3489051020638496),
        CGPoint(x: 0.3689883787240555, y: 0.35766422615144083),
        CGPoint(x: 0.3665008165350008, y: 0.36204378819523647),
        CGPoint(x: 0.36401325434594606, y: 0.36836981483329534),
        CGPoint(x: 0.36152569215689134, y: 0.3751824743266233),
        CGPoint(x: 0.3590381299678366, y: 0.3815085009646822),
        CGPoint(x: 0.35572139303482586, y: 0.3883211604580102),
        CGPoint(x: 0.35074626865671643, y: 0.40097323600973234),
        CGPoint(x: 0.34742949376651894, y: 0.40875911666238973),
        CGPoint(x: 0.34577114427860695, y: 0.41411192214111925),
        CGPoint(x: 0.3424543693884095, y: 0.42043794877917806),
        CGPoint(x: 0.3383084577114428, y: 0.4257907542579075),
        CGPoint(x: 0.3349916828212453, y: 0.4321167808959664),
        CGPoint(x: 0.3300165584431359, y: 0.4437956130127547),
        CGPoint(x: 0.32669982151012517, y: 0.4496350290711489),
        CGPoint(x: 0.3233830845771144, y: 0.45547444512954305),
        CGPoint(x: 0.3208955223880597, y: 0.4608272506082725),
        CGPoint(x: 0.31757874749786225, y: 0.4671532772463314),
        CGPoint(x: 0.31592039800995025, y: 0.47299269330472554),
        CGPoint(x: 0.31094527363184077, y: 0.48418491484184917),
        CGPoint(x: 0.30928688618674205, y: 0.4909975520595727),
        CGPoint(x: 0.30679932399768733, y: 0.49927006556749925),
        CGPoint(x: 0.30679932399768733, y: 0.5060827250608273),
        CGPoint(x: 0.30679932399768733, y: 0.51338199513382),
        CGPoint(x: 0.30679932399768733, y: 0.5201946323515435),
        CGPoint(x: 0.30762849874164333, y: 0.5338199513381995),
        CGPoint(x: 0.30845771144278605, y: 0.5401459779762584),
        CGPoint(x: 0.31094527363184077, y: 0.5498783454987834),
        CGPoint(x: 0.3126036231197528, y: 0.556690982716507),
        CGPoint(x: 0.31592039800995025, y: 0.563503642209835),
        CGPoint(x: 0.31923713494296097, y: 0.5688564476885645),
        CGPoint(x: 0.32587064676616917, y: 0.5751824743266233),
        CGPoint(x: 0.3308457711442786, y: 0.5790754257907542),
        CGPoint(x: 0.3374792450103001, y: 0.5834549878345499),
        CGPoint(x: 0.34328358208955223, y: 0.5873479170230763),
        CGPoint(x: 0.34660031902256294, y: 0.5883211604580102),
        CGPoint(x: 0.3499170559555737, y: 0.5888077710376749),
        CGPoint(x: 0.35489218033368314, y: 0.5883211604580102),
        CGPoint(x: 0.3731343283582089, y: 0.5854014524288131),
        CGPoint(x: 0.3822553644132851, y: 0.5829683549792807),
        CGPoint(x: 0.3872304887913946, y: 0.5810218903850175),
        CGPoint(x: 0.39054726368159204, y: 0.5790754257907542),
        CGPoint(x: 0.39386400061460275, y: 0.5766423283412219),
        CGPoint(x: 0.39718073754761346, y: 0.5746958637469586),
        CGPoint(x: 0.40132668718176695, y: 0.5717761557177615),
        CGPoint(x: 0.40215586192572295, y: 0.5708029122828276),
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
        guard !randomStoke.isEmpty else { return }
        
        for stroke in randomStoke {
            let bbox = stroke.boundingBox()

            for point in stroke {
                XCTAssertTrue(point.isInside(rect: bbox))
            }
        }
   }
    
    @MainActor func test_prop_refit_into_boundingbox_is_identity() throws {
        guard randomStoke.count > 0 else { return }

        for stroke in randomStoke {
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
        guard randomStoke.count > 0 && CGRect.isValidBox(originX: 0.0, originY: 0.0, bottomTrailingX: 1.0, bottomTrailingY: 1.0) else { return }
        
        for stroke in randomStoke {
            let refitted = stroke.refit(normalAABB)
            
            for point in refitted {
                XCTAssertTrue(point.isInside(rect: normalAABB))
            }
        }
    }
    
    @MainActor func test_prop_refit_idempotent() throws {
        let normalAABB = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        guard randomStoke.count > 0 && CGRect.isValidBox(originX: 0.0, originY: 0.0, bottomTrailingX: 1.0, bottomTrailingY: 1.0) else { return }

        for stroke in randomStoke {
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
        for stroke in randomStoke {
            if let firstPointInStroke = stroke.first {
                let redistributeStroke = stroke.redistribute(150)
                
                XCTAssertEqual(stroke.count, redistributeStroke.count)
                
                if let firstRedistributedPoint = redistributeStroke.first {
                    XCTAssertEqual(firstPointInStroke.x, firstRedistributedPoint.x)
                    XCTAssertEqual(firstPointInStroke.y, firstRedistributedPoint.y)
                }
            }
        }
    }
    
    @MainActor func test_prop_redistdribute_preserves_last_point() throws {
        for stroke in randomStoke {
            if let lastPointInStroke = stroke.last {
                let redistributeStroke = stroke.redistribute(5)
                
                if let lastRedistributedPoint = redistributeStroke.last {
                    XCTAssertEqual(lastPointInStroke.x, lastRedistributedPoint.x)
                    XCTAssertEqual(lastPointInStroke.y, lastRedistributedPoint.y)
                }
            }
        }
    }
}



/*#include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>

 typedef struct {
     double x;
     double y;
 } Point;

 typedef struct {
     Point* points;
     size_t length;
 } Stroke;

 bool prop_redistdribute_preserves_last_point(double d, Stroke stroke) {
     if (d <= 3 * delta || stroke.length == 0) return true;
     Point last = stroke.points[stroke.length - 1];
     Stroke redistributed = redistribute(d, stroke);
     return equal(redistributed.points[redistributed.length - 1], last);
 }

 int main() {
     // Assuming quickCheck function is defined elsewhere
     quickCheck(prop_stroke_fits_inside_bounding_box);
     quickCheck(prop_refit_fits_inside);
     quickCheck(prop_refit_into_boundingbox_is_identity);
     quickCheck(prop_refit_idempotent);
     quickCheck(prop_redistdribute_preserves_first_point);
     quickCheck(prop_redistdribute_preserves_last_point);
     return 0;
 }*/
