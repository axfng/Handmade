import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredProducts: [Product] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // Call this method to filter products
    func filterProducts(products: [Product]) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { product in
                product.tags.contains { tag in
                    tag.localizedStandardContains(searchText)
                }
            }
        }
    }

}
