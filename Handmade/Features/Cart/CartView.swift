import SwiftUI

struct CartView: View {
    @Binding var userId: String
    @State private var showCheckoutView = false
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Shopping Cart")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                    .padding()
            }
                ScrollView {
                    ForEach (cartViewModel.cartItems) { item in
                        CartProductView(cartItem: item)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                VStack {
                    Text("Total: \(cartViewModel.totalCost, specifier: "%.2f")")
                        .font(.headline)
                        .padding(.top)

                    Button {
                        showCheckoutView.toggle()
                    } label: {
                        Text("Proceed to Checkout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Cart")
        .popover(isPresented: $showCheckoutView) {
            CheckoutView()
        }
    }
}

#Preview {
    CartView(userId: .constant("jhskS1cGXWQTCX7ioLw3XGrvfjI3"))
        .environmentObject(AuthViewModel())
        .environmentObject(ProductViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
