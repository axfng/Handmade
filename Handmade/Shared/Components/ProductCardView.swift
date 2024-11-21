//
//  ProductCardView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject var userSession: UserSessionViewModel

    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(10)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .lineLimit(1)
                Text(product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .bold()
                Text(product.description.capitalized)
                    .font(.subheadline)
                HStack {
                    Button{
//                        let cartItem = CartItem(id: product.id, product: product, quantity: 1)
                        cartViewModel.addToCart(product: product)
                    } label: {
                        Text("Add to Cart")
                    }
                    Button{
//                        savedViewModel.toggleLike(for: product)
//                        if !userSession.savedList.contains(where: { $0.id == product.id }) {
//                            userSession.savedList.append(product)
//                        }
                        savedViewModel.toggleLike(for: product)
                    } label: {
                        Image(systemName: savedViewModel.isLiked(product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical, 10)
            }
            .frame(alignment: .leading)
            
            Spacer()
        }
    }
}

#Preview {
    ProductCardView(product: Product(id: 1, title: "Sample Product", description: "A great product", price: 19.99, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png", tags: ["Beauty"]))
        .environmentObject(SavedViewModel())
}
