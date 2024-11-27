import SwiftUI

struct LoadingView: View {
    
    @State private var animationAmount = 0.0
    let letters1 = Array("Handmade")
    let letters2 = Array("by Heels")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false

    
    var body: some View {
        ZStack {
            Color(enabled ? Color(red: 0.48, green: 0.68, blue: 0.9) : .white).ignoresSafeArea()
            VStack{
                HStack(spacing:0) {
                    ForEach(0..<letters1.count, id: \.self){num in
                        Text(String(letters1[num]))
                            .padding(8)
                            .font(.title3)
                        //  .foregroundStyle(enabled ? Color(red: 0.48, green: 0.68, blue: 0.9) : .white)
                            .background(enabled ? .white : Color(red: 0.48, green: 0.68, blue: 0.9))
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 10), value: dragAmount)
                    }
                }
                HStack(spacing:0) {
                    ForEach(0..<letters2.count, id: \.self){num in
                        Text(String(letters2[num]))
                            .padding(8)
                            .font(.title3)
                        //  .foregroundStyle(enabled ? Color(red: 0.48, green: 0.68, blue: 0.9) : .white)
                            .background(enabled ? .white : Color(red: 0.48, green: 0.68, blue: 0.9))
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
                        enabled.toggle()
                    }
            )
        }
        .animation(.linear.delay(1 / 15), value: dragAmount)
    }
}

#Preview {
    LoadingView()
}
