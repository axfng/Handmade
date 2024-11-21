//
//  ProductViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation
import Combine

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let productService: ProductService
    
    init(productService: ProductService = ProductService()) {
        self.productService = productService
        Task {
            print("Calling fetchProducts")
            await fetchProducts()
        }
    }
    
    func fetchProducts() async {
        do {
            self.products = try await productService.getProducts()
            print("Products fetched: \(products)")
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
}
