import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject private var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject private var savedViewModel: SavedViewModel
    
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            Text("Search Items")
                .font(.title.bold())
            TextField("Search for Items", text: $searchViewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundStyle(.black)
                .padding(.horizontal, 10)
            
            ScrollView {
                ForEach(searchViewModel.filteredProducts, id: \.id) { product in
                    ProductCardView(product: product)
                }
                .padding(.horizontal, 15)
            }
        }
        .onChange(of: searchViewModel.searchText) {
            searchViewModel.filterProducts(products: productViewModel.products)
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
