//
//  ProductView.swift
//  Handmade
//
//  Created by alfeng on 11/29/24.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        HStack(spacing: 4) {
                            ForEach(0..<5) { index in
                                star(for: index)
                                    .foregroundColor(.yellow)
                                    .frame(width: 18, height: 24)
                            }
                        }
                        Text("\(product.formattedRating)")
                            .foregroundStyle(.yellow)
                        Text("(" + "\(product.reviews.count)" + ")")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .padding(.top, 15)
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
                    Text("$" + "\(product.formattedPrice)")
                        .font(.title).bold()
                    HStack {
                        Button{
                            cartViewModel.addToCart(product: product, authViewModel: viewModel)
                        } label: {
                            Text("Add to Cart")
                                .foregroundStyle(.white)
                        }
                        .padding(9)
                        .frame(maxWidth: .infinity)
                        .background(Color(.blue))
                        .clipShape(Capsule())
                        Button{
                            savedViewModel.toggleLike(for: product, authViewModel: viewModel)
                        } label: {
                            Image(systemName: savedViewModel.isLiked(product) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        .padding(11)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .clipShape(Capsule())
                    }
                    .padding(.bottom, 15)
                    
                    Text("Description")
                        .font(.custom("Review", size: 25.0))
                        .padding(.bottom, 5)
                
                    Text(product.description)
                        .padding(.bottom, 15)

                    HStack {
                        Text("Reviews")
                            .font(.custom("Review", size: 25.0))
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    ForEach(product.reviews, id: \.reviewerName) { review in
                        ReviewView(review: review)
                    }
                }
                .padding(.horizontal, 15)
            }
            .navigationTitle(product.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func star(for index: Int) -> some View {
        ZStack {
            Image(systemName: "star.fill")
                .foregroundColor(.gray)
                .opacity(0.8)

            if product.rating > Double(index) {
                let fillPercentage = min(max(product.rating - Double(index), 0), 1.0)
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .overlay(
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.gray.opacity(0.8))
                                .frame(width: geometry.size.width * (1.0 - fillPercentage), height: geometry.size.height)
                                .offset(x: geometry.size.width * fillPercentage)
                        }
                        .allowsHitTesting(false)
                    )
                    .mask(
                        Image(systemName: "star.fill")
                    )
            }
        }
    }
}

#Preview {
    let review1: Review = Review(rating: 2, comment: "Very unhappy with my purchase!", date: "2024-05-23T08:56:21.618Z", reviewerName: "John Doe", reviewerEmail: "john.doe@x.dummyjson.com")
    let review2: Review = Review(rating: 2, comment: "Not as described!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Nolan Gonzalez", reviewerEmail: "nolan.gonzalez@x.dummyjson.com")
    let review3: Review = Review(rating: 5, comment: "Very satisfied!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Scarlett Wright", reviewerEmail: "scarlett.wright@x.dummyjson.com")
    return ProductView(product: Product(id: 1, title: "Essence Mascara Lash Princess", description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.", price: 19.99, rating: 3.7, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png", tags: ["Beauty"], reviews: [review1, review2, review3]))
        .environmentObject(SavedViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(CartViewModel())
}
