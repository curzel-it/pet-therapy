// 
// Pet Therapy.
// 

import Biosphere
import SwiftUI

extension EntityAnimation {
    
    public static let front = EntityAnimation(id: "front")
    
    static let backflip = EntityAnimation(id: "backflip")
    static let eat = EntityAnimation(id: "eat")
    static let fireball = EntityAnimation(id: "fireball")
    static let idle = EntityAnimation(id: "idle")
    static let jump = EntityAnimation(id: "jump")
    static let love = EntityAnimation(id: "love")
    static let meditate = EntityAnimation(id: "meditate")
    static let playGuitar = EntityAnimation(id: "guitar")
    static let puke = EntityAnimation(id: "puke")
    static let roar = EntityAnimation(id: "roar")
    static let selfie = EntityAnimation(id: "selfie")
    static let sendText = EntityAnimation(id: "texting")
    static let tsundere = EntityAnimation(id: "tsundere")
    
    static func lightsaber(size: CGSize) -> EntityAnimation {
        .init(id: "lightsaber", size: size, chance: 0.1)
    }
}
