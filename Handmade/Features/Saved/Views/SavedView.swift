//
//  SavedViews.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct SavedView: View {
    @Binding var userId: String
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var userSession: UserSessionViewModel

    var body: some View {
        VStack {
            Text("Saved Items")
                .font(.title.bold())
                .foregroundStyle(.blue)
                .padding()

            if savedViewModel.savedItems.isEmpty {
                Text("Your saved list is empty.")
                    .foregroundStyle(.gray)
                    .padding()
            } else {
                ScrollView {
                    ForEach(savedViewModel.savedItems) { product in
                        ProductCardView(product: product)
                            .swipeActions {
                                Button(role: .destructive) {
                                    savedViewModel.toggleLike(for: product, authViewModel: viewModel)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            
            Spacer()
        }
        .navigationTitle("Saved")
    }
}

#Preview {
    SavedView(userId: .constant("UAOrPcizD3VHqaepr9E3CGHr4Aq2"))
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
        .environmentObject(UserSessionViewModel())
}
