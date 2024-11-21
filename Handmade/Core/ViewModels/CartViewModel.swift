//
//  CartViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var clientSecret: String?
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(id: product.id, title: product.title, thumbnail: product.thumbnail, price: product.price, quantity: 1))
        }
    }
    
    func removeFromCart(id: Int) {
        cartItems.removeAll { $0.id == id }
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
    
    func startCheckout() async {
        let totalAmount = calculateTotalAmount()
        do {
            self.clientSecret = try await StripeService.shared.createPaymentIntent(amount: totalAmount)
        } catch {
            print("Error creating payment intent: \(error)")
        }
    }
    
    private func calculateTotalAmount() -> Int {
        let totalInDollars = cartItems.reduce(0.0) { $0 + $1.totalPrice * Double($1.quantity) }
        let totalInCents = Int(totalInDollars * 100)
        return totalInCents
    }
}
