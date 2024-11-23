//
//  ContentView.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
//
// 在SwiftUI中视图上添加点击事件

import SwiftUI


struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView:View {
    @State var isFaceUp = false // 是否正面朝上
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
//            let base = Circle()
            if isFaceUp{
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            }else{
                    base.fill()
            }
        }
        .onTapGesture {
            debugPrint("tapped")
            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
