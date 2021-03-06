//
// Pet Therapy.
//

import AppState
import Biosphere
import DesignSystem
import LiveEnvironment
import Pets
import PetsAssets
import Schwifty
import Sprites
import Squanch
import SwiftUI

class PetSelectionViewModel: LiveEnvironment {
    
    @Published var selectedPet: SelectablePet?
            
    lazy var showingDetails: Binding<Bool> = {
        Binding {
            self.selectedPet != nil
        } set: { isShown in
            guard !isShown else { return }
            self.selectedPet = nil
        }
    }()
    
    let petSize: CGFloat = 90
    
    init() {
        super.init(id: "PetSelection", bounds: .zero)
        let pets = Pet.availableSpecies.map { species in
            SelectablePet(of: species, size: petSize, in: state.bounds)
        }
        state.children.append(contentsOf: pets)
    }
    
    func showDetails(of pet: SelectablePet?) {
        selectedPet = pet
    }
    
    func closeDetails() {
        selectedPet = nil
    }
}

class SelectablePet: PetEntity {
        
    init(of pet: Pet, size: CGFloat, in habitatBounds: CGRect) {
        super.init(
            of: pet,
            size: size,
            in: habitatBounds,
            installCapabilities: false
        )
        install(AnimatedSprite.self)
        install(PetSpritesProvider.self)
        set(direction: .zero)
        set(state: .animation(animation: .front, loops: nil))
    }
}
