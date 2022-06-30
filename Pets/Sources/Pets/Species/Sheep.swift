//
// Pet Therapy.
//

import Foundation
import Biosphere

extension Pet {
    
    static let sheep = Pet(
        id: "sheep",
        behaviors: [
            .init(
                trigger: .onAnyCorner,
                possibleAnimations: [
                    .idleFront,
                    .idle,
                    .eat,
                    .puke
                ]   
            )
        ],
        movementPath: .walk,
        speed: 0.8
    )
}
