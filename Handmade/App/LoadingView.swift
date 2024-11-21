//
//  LoadingView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var animationAmount = 0.0
    let letters1 = Array("Handmade")
    let letters2 = Array("by Heels")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false

    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<letters1.count, id: \.self){num in
                Text(String(letters1[num]))
                    .padding(5)
                    .font(.title3)
                    .background(enabled ? Color(.blue) : .teal)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 10), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged{dragAmount = $0.translation}
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
        HStack(spacing:0) {
            ForEach(0..<letters2.count, id: \.self){num in
                Text(String(letters2[num]))
                    .padding(5)
                    .font(.title3)
                    .background(enabled ? Color(.blue) : .teal)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 10
                                            ), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged{dragAmount = $0.translation}
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    LoadingView()
}
