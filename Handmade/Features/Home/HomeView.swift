import SwiftUI

struct HomeView: View {
    @Binding var isSignedIn: Bool
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel


    var body: some View {
        NavigationStack {
            HStack {
                Text("Handmade by Heels")
                    .font(.title).bold()
                NavigationLink {
                    ProfileView(isSignedIn: $isSignedIn)
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color(red: 75/255, green: 156/255, blue: 211/255))
                }
            }
            ScrollView {
                ForEach(productViewModel.products, id: \.id) { product in
                    ProductCardView(product: product)
                }
                .padding(.horizontal, 15)
            }
            Spacer()
        }
        .onAppear {
            Task {
                await productViewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    HomeView(isSignedIn: .constant(true))
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
