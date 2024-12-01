import FirebaseFirestore
import FirebaseAuth
import Foundation
import SwiftUI

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    private let productService: ProductService
    
    init(productService: ProductService = ProductService()) {
        self.productService = productService
    }
    
    func fetchCartItemIDs(userId: String) {
        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists, let data = document.data(),
                  let cartItemIds = data["cartItems"] as? [Int] else {
                print("Document does not exist or data is malformed.")
                return
            }
            print("Fetched cart item IDs: \(cartItemIds)")
            self?.fetchProducts(for: cartItemIds)
        }
    }
    
    private func fetchProducts(for ids: [Int]) {
        var cart: [Product] = []
        Task {
            do {
                let allProducts = try await productService.getProducts()
                DispatchQueue.main.async {
                    cart = allProducts.filter { ids.contains($0.id) }
                    for item in cart {
                        self.cartItems.append(CartItem(id: item.id, title: item.title, thumbnail: item.images[0], price: item.price, quantity: 1))
                    }
                }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }
    
    func addToCart(product: Product, authViewModel: AuthViewModel) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            cartItems[index].quantity += 1
            updateCartItemsInFirestore(authViewModel: authViewModel)
        } else {
            cartItems.append(CartItem(id: product.id, title: product.title, thumbnail: product.images[0], price: product.price, quantity: 1))
            updateCartItemsInFirestore(authViewModel: authViewModel)
        }
    }

    private func updateCartItemsInFirestore(authViewModel: AuthViewModel) {
        let cartItemIds = cartItems.map { $0.id }
        Task {
            await authViewModel.updateCartItems(with: cartItemIds)
        }
    }
    
    func removeFromCart(cartItem: CartItem, authViewModel: AuthViewModel) {
        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            cartItems.remove(at: index)
            updateCartItemsInFirestore(authViewModel: authViewModel)
        }
        cartItems.removeAll { $0.id == cartItem.id }
    }
    
    func clearCart() {
            cartItems.removeAll()
        }
        
    var totalCost: Double {
        cartItems.reduce(0) { $0 + $1.totalPrice }
    }
    
    var totalItems: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    private func calculateTotalAmount() -> Int {
        let totalInDollars = cartItems.reduce(0.0) { $0 + $1.totalPrice * Double($1.quantity) }
        let totalInCents = Int(totalInDollars * 100)
        return totalInCents
    }
}
