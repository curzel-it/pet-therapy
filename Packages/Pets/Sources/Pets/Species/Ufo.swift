//
// Pet Therapy.
//

import Biosphere
import SwiftUI

extension Pet {
    
    public static let ufo = Pet(
        id: "ufo",
        behaviors: [
            .init(
                trigger: .on(spot: .horizontalCenter),
                possibleAnimations: [
                    .bombing,
                    .landing,
                    .enterPortal,
                    .crash
                ]
            )
        ],
        capabilities: .defaultsNoGravity,
        isPaid: true,
        movementPath: .front,
        dragPath: .front,
        speed: 2.4
    )
}
    
private extension EntityAnimation {
    
    static let bombing = EntityAnimation(
        id: "bombing",
        size: CGSize(width: 4, height: 2)
    )
    
    static let landing = EntityAnimation(id: "landing")
    
    static let enterPortal = EntityAnimation(
        id: "portal",
        size: CGSize(width: 2, height: 1)
    )
    
    static let crash = EntityAnimation(
        id: "crash",
        size: CGSize(width: 2, height: 1)
    )
}
