import SwiftUI

struct CartProductView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel

    let cartItem: CartItem

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: cartItem.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Image load error")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 85, height: 85)

            VStack(alignment: .leading, spacing: 5) {
                Text(cartItem.title)
                    .font(.headline).bold()
                    .lineLimit(1)
                HStack {
                    Text("Price: \(cartItem.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD")),")
                        .font(.subheadline)
                    Text("Quantity: \(cartItem.quantity)")
                        .font(.subheadline)
                }
                .foregroundColor(.secondary)
                .padding(.vertical, 3)
                
                HStack {
                    Text("Total: \(cartItem.totalPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .font(.headline)
                    Spacer()
                    HStack {
                        Button(role: .destructive) {
                            cartViewModel.removeFromCart(cartItem: cartItem, authViewModel: viewModel)
                        } label: {
                            Label("Remove", systemImage: "trash")
                        }
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    return CartProductView(cartItem: CartItem(id: 1, title: "Essence Mascara Lash Princess", thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png", price: 19.99, quantity: 2))
        .environmentObject(SavedViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(CartViewModel())
}
