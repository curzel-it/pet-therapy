//
// Pet Therapy.
//

import AppState
import Biosphere
import InAppPurchases
import OnScreen
import Pets
import SwiftUI
import Schwifty
import Tracking

@main
struct MyApp: App {
    
    // swiftlint:disable weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Tracking.setup(isEnabled: AppState.global.trackingEnabled)
        PricingService.global.setup()
        Task { @MainActor in
            OnScreen.show()
            StatusBarItems.main.setup()
        }
    }
    
    var body: some Scene {
        MainWindow()
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // ...
    }
    
    func applicationDidChangeScreenParameters(_ notification: Notification) {
        OnScreen.hide(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            OnScreen.show()
        }
    }
}
