import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel

    
    @StateObject private var searchViewModel: SearchViewModel
    init(productViewModel: ProductViewModel) {
        _searchViewModel = StateObject(wrappedValue: SearchViewModel(productViewModel: productViewModel))
    }



    var body: some View {
        VStack {
            TextField("Search for Items", text: $searchViewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            ScrollView {
                ForEach (searchViewModel.filteredProducts) { product in
                    ProductCardView(product: product)
                }
            }
        }
        .navigationTitle("Search")
    }
}

#Preview {
    SearchView(productViewModel: ProductViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
