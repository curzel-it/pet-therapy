// 
// Pet Therapy.
// 

import Lang
import InAppPurchases
import SwiftUI
import Tracking

class PetDetailsViewModel: ObservableObject {
    
    @Binding var isShown: Bool
    
    @Published var buyTitle: String = ""
    
    let child: PetEntity
    
    var title: String { child.species.name }
    
    var pricing: PricingService { PricingService.global }
    var isFree: Bool { !child.species.isPaid }
    var hasBeenPaid: Bool { pricing.didPay(for: child.species) }
    var canSelect: Bool { isFree || hasBeenPaid }
    var canBuy: Bool { !isFree && !hasBeenPaid }
    var price: PetPrice? { pricing.price(for: child.species) }
        
    init(isShown: Binding<Bool>, child: PetEntity) {
        self._isShown = isShown
        self.child = child
        
        if let formatted = price?.formattedPrice {
            animateBuyTitle("\(Lang.Purchases.buyFor) \(formatted)")
        } else {
            animateBuyTitle("")
        }
    }
 
    func close() {
        withAnimation {
            isShown = false
        }
    }
    
    func select() {
        AppState.global.selectedPet = child.species
        Tracking.didSelect(child.species)
        close()
    }
    
    func buy() {
        guard let item = price else {
            Tracking.didBuy(child.species, success: false)
            return
        }
        animateBuyTitle(Lang.Purchases.purchasing)        
        
        Task {
            let succeed = await PricingService.global.buy(item)
            Tracking.didBuy(child.species, success: succeed)
            
            Task { @MainActor in
                if succeed {
                    animateBuyTitle(Lang.Purchases.purchased)
                } else {
                    animateBuyTitle(Lang.somethingWentWrong)
                    animateBuyTitle(Lang.loading, delay: 2)
                }
            }
        }
    }
    
    func animateBuyTitle(_ value: String, delay: TimeInterval=0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            withAnimation {
                self?.buyTitle = value
            }
        }
    }
}
