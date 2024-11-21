//
//  ContentView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isSignedIn: Bool
    
    @StateObject private var viewModel = AuthViewModel()
    @StateObject private var productViewModel = ProductViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var savedViewModel = SavedViewModel() 
    @StateObject private var userSession = UserSessionViewModel()


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
                .environmentObject(userSession)

            SearchView(productViewModel: ProductViewModel())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
                .environmentObject(userSession)

            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
                .environmentObject(userSession)

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .environmentObject(viewModel)
                .environmentObject(productViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
                .environmentObject(userSession)
        
        }
    }
}

#Preview {
    MainTabView(isSignedIn: .constant(true))
}
