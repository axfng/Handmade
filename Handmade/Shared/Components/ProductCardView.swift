import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel

    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.images[0])) { phase in
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
            .frame(width: 128, height: 128)
            .clipped()
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                NavigationLink {
                    ProductView(product: product)
                } label: {
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.custom("Title", size: 17.0))
                            .lineLimit(1)
                        Text(product.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.headline).italic()
                        Text(product.tags[0])
                            .foregroundStyle(Color(.systemGray))
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray5))
                            .clipShape(.rect(cornerRadius: 4.0))
                    }
                }
                .foregroundStyle(.black)
                
                HStack {
                    Button{
                        cartViewModel.addToCart(product: product, authViewModel: viewModel)
                    } label: {
                        Text("Add to Cart")
                            .foregroundStyle(.white)
                    }
                    .padding(9)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 75/255, green: 156/255, blue: 211/255))
                    .clipShape(Capsule())
                    Button{
                        savedViewModel.toggleLike(for: product, authViewModel: viewModel)
                    } label: {
                        Image(systemName: savedViewModel.isLiked(product) ? "heart.fill" : "heart")
                            .foregroundColor(savedViewModel.isLiked(product) ? .red : Color(.systemGray))
                    }
                    .padding(11)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                }
                .padding(.vertical, 5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let review1: Review = Review(rating: 2, comment: "Very unhappy with my purchase!", date: "2024-05-23T08:56:21.618Z", reviewerName: "John Doe", reviewerEmail: "john.doe@x.dummyjson.com")
    let review2: Review = Review(rating: 2, comment: "Not as described!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Nolan Gonzalez", reviewerEmail: "nolan.gonzalez@x.dummyjson.com")
    let review3: Review = Review(rating: 5, comment: "Very satisfied!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Scarlett Wright", reviewerEmail: "scarlett.wright@x.dummyjson.com")
    return ProductCardView(product: Product(id: 1, title: "Essence Mascara Lash Princess", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", price: 19.99, rating: 4.94, images: [
        "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"
      ], tags: ["Beauty"], reviews: [review1, review2, review3]))
        .environmentObject(SavedViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(CartViewModel())
}
