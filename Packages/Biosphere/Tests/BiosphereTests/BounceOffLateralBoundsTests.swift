//
// Pet Therapy.
//

import XCTest

@testable import Biosphere

class BounceOffLateralBoundsTests: XCTestCase {
    
    private let testEnv = Environment(
        bounds: CGRect(x: 0, y: 0, width: 100, height: 100)
    )
    
    private lazy var testRightBound = { testEnv.rightBound() }()
    private lazy var testLeftBound = { testEnv.leftBound() }()
    
    private var testEntity: Entity!
    private var bounce: BounceOffLateralBounds!
    
    override func setUp() {
        testEntity = Entity(
            id: "entity",
            frame: CGRect(x: 10, y: 10, width: 10, height: 10),
            in: testEnv.bounds
        )
        bounce = BounceOffLateralBounds(with: testEntity)
        testEntity.capabilities = [bounce]
    }
    
    func testBouncesToLeftWhenHittingRight() {
        testEntity.set(
            origin: CGPoint(
                x: testRightBound.frame.origin.x - testEntity.frame.width,
                y: 0
            )
        )
        testEntity.set(direction: .init(dx: 1, dy: 0))
        
        let collisions = testEntity.collisions(with: [testRightBound])
        let angle = bounce.bouncingAngle(collisions: collisions)
        XCTAssertEqual(angle, .pi)
        
        testEntity.update(with: collisions, after: 0.01)
        XCTAssertEqual(testEntity.direction.dx, -1, accuracy: 0.00001)
        XCTAssertEqual(testEntity.direction.dy, 0, accuracy: 0.00001)
    }
    
    func testBouncesToRightWhenHittingLeft() {
        testEntity.set(
            origin: CGPoint(
                x: testLeftBound.frame.maxX,
                y: 0
            )
        )
        testEntity.set(direction: .init(dx: -1, dy: 0))
        
        let collisions = testEntity.collisions(with: [testLeftBound])
        let angle = bounce.bouncingAngle(collisions: collisions)
        XCTAssertEqual(angle, 0)
        
        testEntity.update(with: collisions, after: 0.01)
        XCTAssertEqual(testEntity.direction.dx, 1, accuracy: 0.00001)
        XCTAssertEqual(testEntity.direction.dy, 0, accuracy: 0.00001)
    }
}
