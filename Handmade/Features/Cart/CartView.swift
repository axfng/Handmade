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
            }
                ScrollView {
                    ForEach (cartViewModel.cartItems) { item in
                        CartProductView(cartItem: item)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .padding(.horizontal, 15)
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
                            .background(Color(red: 75/255, green: 156/255, blue: 211/255))
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
