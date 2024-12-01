import SwiftUI

struct MainTabView: View {
    @Binding var isSignedIn: Bool
    @Binding var userId: String
    
    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var savedViewModel = SavedViewModel() 


    var body: some View {
        
        TabView {
            HomeView(isSignedIn: $isSignedIn)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)

            SavedView(userId: $userId)
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)

            CartView(userId: $userId)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
        
        }
        .tint(Color(red: 75/255, green: 156/255, blue: 211/255))
        .onAppear {
            savedViewModel.fetchSavedProductIDs(userId: userId)
            cartViewModel.fetchCartItemIDs(userId: userId)
        }
    }
    
}

#Preview {
    MainTabView(isSignedIn: .constant(true), userId: .constant("UAOrPcizD3VHqaepr9E3CGHr4Aq2"))
}
