//
//  ReviewView.swift
//  Handmade
//
//  Created by alfeng on 11/29/24.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    
    var body: some View {
        VStack {
            HStack {
                Text(review.reviewerName)
                    .font(.headline)
                Spacer()
                Text(review.formattedDate)
                    .foregroundStyle(.gray)
            }
            HStack(spacing: 4) {
                ForEach(0..<5) { index in
                    star(for: index)
                        .foregroundColor(.yellow)
                        .frame(width: 18, height: 20)
                }
                Spacer()
            }
            .padding(.bottom, 5)
            HStack {
                Text(review.comment)
                Spacer()
            }
            .padding(.bottom, 5)
            Divider()
        }
    }
    
    @ViewBuilder
    private func star(for index: Int) -> some View {
        ZStack {
            Image(systemName: "star.fill")
                .foregroundColor(.gray)
                .opacity(0.8)

            if review.rating > Double(index) {
                let fillPercentage = min(max(review.rating - Double(index), 0), 1.0)
                
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
    let review: Review = Review(rating: 2, comment: "Very unhappy with my purchase!", date: "2024-05-23T08:56:21.618Z", reviewerName: "John Doe", reviewerEmail: "john.doe@x.dummyjson.com")
    return ReviewView(review: review)
}
