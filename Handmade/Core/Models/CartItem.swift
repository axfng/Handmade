import Foundation

struct CartItem: Identifiable, Codable {
    let id: Int // This should match the Product ID for easy lookup
    let title: String
    let thumbnail: String
    let price: Double
    var quantity: Int
    
    var totalPrice: Double {
        return Double(quantity) * price
    }
}
