import Foundation

class ProductService {
    func getProducts() async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return productResponse.products
    }
}

struct ProductResponse: Codable {
    let products: [Product]
}
