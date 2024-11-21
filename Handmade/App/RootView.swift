//
//  RootView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var loadScreen = true
    @State private var isSignedIn: Bool
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var userSession: UserSessionViewModel
    
    init() {
        _isSignedIn = State(initialValue: Auth.auth().currentUser != nil)
    }
 
    var body: some View {
        Group {
            if loadScreen {
                LoadingView()
                    .transition(.opacity)
            } else {
                if isSignedIn {
                    MainTabView(isSignedIn: $isSignedIn)
                        .environmentObject(viewModel)
                        .environmentObject(productViewModel)
                        .environmentObject(cartViewModel)
                        .environmentObject(savedViewModel)
                } else {
                    LoginView(isSignedIn: $isSignedIn)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    loadScreen.toggle()
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
        .environmentObject(UserSessionViewModel())
}
