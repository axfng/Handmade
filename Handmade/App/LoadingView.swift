import SwiftUI

struct LoadingView: View {
    
    @State private var animationAmount = 0.0
    let letters1 = Array("Handmade")
    let letters2 = Array("by Heels")
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false

    
    var body: some View {
        ZStack {
            VStack{
                HStack(spacing:0) {
                    ForEach(0..<letters1.count, id: \.self){num in
                        Text(String(letters1[num]))
                            .padding(8)
                            .font(.title3)
                            .background(Color(red: 75/255, green: 156/255, blue: 211/255))
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 10), value: dragAmount)
                    }
                }
                HStack(spacing:0) {
                    ForEach(0..<letters2.count, id: \.self){num in
                        Text(String(letters2[num]))
                            .padding(8)
                            .font(.title3)
                            .background(Color(red: 75/255, green: 156/255, blue: 211/255))
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 10), value: dragAmount)
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged{dragAmount = $0.translation}
                    .onEnded { _ in
                        dragAmount = .zero
                    }
            )
        }
        .animation(.linear.delay(1 / 15), value: dragAmount)
    }
}

#Preview {
    LoadingView()
}
