//
//  SearchViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    private var productViewModel: ProductViewModel
    
    @Published var searchText: String = ""
    @Published var filteredProducts: [Product] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(productViewModel: ProductViewModel) {
        self.productViewModel = productViewModel
        $searchText
            .combineLatest(productViewModel.$products)
            .map { searchText, products in
                if searchText.isEmpty {
                    return products
                } else {
                    return products.filter { product in
                        product.tags.contains { tag in
                            tag.localizedStandardContains(searchText)
                        }
                    }
                }
            }
            .assign(to: &$filteredProducts)
    }
}
