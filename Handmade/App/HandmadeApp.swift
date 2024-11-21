//
//  HandmadeApp.swift
//  Handmade
//
//  Created by alfeng on 11/7/24.
//

import SwiftUI
import FirebaseCore

@main
struct HandmadeApp: App {
    @StateObject private var userSession = UserSessionViewModel()
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
                .environmentObject(userSession)
        }
    }
}
