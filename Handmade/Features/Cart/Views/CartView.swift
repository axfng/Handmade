//
//  CartView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var userSession: UserSessionViewModel

//    let user: User? = viewModel.currentUser


    var body: some View {
        VStack {
            HStack {
                Text("Shopping Cart")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                    .padding()
            }
//
//            if userSession.cart.isEmpty {
//                Text("Your shopping cart is empty!")
//                    .foregroundStyle(.gray)
//                    .padding()
//            } else {
                ScrollView {
                    ForEach (cartViewModel.cartItems) { item in
                        CartProductView(cartItem: item)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                VStack {
                    Text("Total: \(cartViewModel.totalCost, specifier: "%.2f")")
                        .font(.headline)
                        .padding(.top)

                    Button {
                        // todo
                    } label: {
                        Text("Proceed to Checkout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
//                }
//                .padding()
            }

            Spacer()
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
        .environmentObject(UserSessionViewModel())
}
