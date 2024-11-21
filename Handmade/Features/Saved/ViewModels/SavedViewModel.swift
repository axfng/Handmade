//
//  SavedViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation
import SwiftUI

@MainActor
class SavedViewModel: ObservableObject {
    @Published var savedItems: [Product] = []

    func toggleLike(for product: Product) {
        if let index = savedItems.firstIndex(where: { $0.id == product.id }) {
            savedItems.remove(at: index)
        } else {
            var likedProduct = product
            likedProduct.isLiked.toggle()
            savedItems.append(likedProduct)
//            updateLikedItemsInFirestore()
        }
    }
    
    func isLiked(_ product: Product) -> Bool {
        savedItems.contains(where: { $0.id == product.id })
    }
}
