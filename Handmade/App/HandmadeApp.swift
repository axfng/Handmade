import SwiftUI
import FirebaseCore

@main
struct HandmadeApp: App {
    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var savedViewModel = SavedViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
        }
    }
}
