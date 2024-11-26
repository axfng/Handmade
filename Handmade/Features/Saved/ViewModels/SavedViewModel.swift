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
    private let productService: ProductService
    
    init(productService: ProductService = ProductService()) {
        self.productService = productService
    }

    func fetchSavedProductIDs(userId: String) {
        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(),
                  let savedItemIds = data["likedItems"] as? [Int] else {
                print("Document does not exist or data is malformed.")
                return
            }
            print("Fetched saved item IDs: \(savedItemIds)")
            self?.fetchProducts(for: savedItemIds)
        }
    }

    private func fetchProducts(for ids: [Int]) {
        Task {
            do {
                let allProducts = try await productService.getProducts()
                print("Fetched products: \(allProducts.map { $0.id })")
                DispatchQueue.main.async {
                    self.savedItems = allProducts.filter { ids.contains($0.id) }
                    print("Filtered saved items: \(self.savedItems.map { $0.id })")
                }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }
    
    func toggleLike(for product: Product, authViewModel: AuthViewModel) {
        if let index = savedItems.firstIndex(where: { $0.id == product.id }) {
            savedItems.remove(at: index)
            updateLikedItemsInFirestore(authViewModel: authViewModel)
        } else {
            var likedProduct = product
            likedProduct.isLiked.toggle()
            savedItems.append(likedProduct)
            updateLikedItemsInFirestore(authViewModel: authViewModel)
        }
    }
    
    func isLiked(_ product: Product) -> Bool {
        savedItems.contains(where: { $0.id == product.id })
    }

    private func updateLikedItemsInFirestore(authViewModel: AuthViewModel) {
        let likedItemIds = savedItems.map { $0.id }
        Task {
            await authViewModel.updateLikedItems(with: likedItemIds)
        }
    }
}
