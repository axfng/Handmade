//
//  HomeView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isSignedIn: Bool
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var userSession: UserSessionViewModel


    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink {
                    ProfileView(isSignedIn: $isSignedIn)
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            HStack {
                Text("Handmade by Heels")
                    .font(.title)
                    .padding(.bottom, 20)
            }
            ScrollView {
                ForEach(productViewModel.products, id: \.id) { product in
                    ProductCardView(product: product)
                }
            }
        }
        .onAppear {
            Task {
                await productViewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    HomeView(isSignedIn: .constant(true))
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
        .environmentObject(UserSessionViewModel())
}
