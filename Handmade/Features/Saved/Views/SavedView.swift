//
//  SavedViews.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var userSession: UserSessionViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Saved Items")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                    .padding()
            }
//            if userSession.savedList.isEmpty {
//                            Text("Your saved list is empty.")
//            } else {
                ScrollView {
                    ForEach (savedViewModel.savedItems) { product in
                        ProductCardView(product: product)
                            .swipeActions {
                                Button(role: .destructive) {
                                    savedViewModel.toggleLike(for: product)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(InsetGroupedListStyle())
//            }
//            if savedViewModel.savedItems.isEmpty {
//                Text("No liked items... yet!")
//                    .foregroundStyle(.gray)
//                    .padding()
//            } else {
//                ScrollView {
//                    ForEach (savedViewModel.savedItems) { product in
//                        ProductCardView(product: product)
//                            .swipeActions {
//                                Button(role: .destructive) {
//                                    savedViewModel.toggleLike(for: product)
//                                } label: {
//                                    Label("Remove", systemImage: "trash")
//                                }
//                            }
//                    }
//                    .listStyle(InsetGroupedListStyle())
//                }
//            }
            
            Spacer()
            
        }
        .navigationTitle("Saved")
    }
}

#Preview {
    SavedView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
        .environmentObject(UserSessionViewModel())
}
