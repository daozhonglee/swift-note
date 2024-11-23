//
//  ContentView.swift
//  emojiArt
//
//  Created by shanquan on 2024/11/23.
//

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
    var isFaceUp = false // 是否正面朝上
    var body: some View {
        ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            }else{
                RoundedRectangle(cornerRadius: 12)
                    .fill()
            }
        }
    }
}

#Preview {
    ContentView()
}
