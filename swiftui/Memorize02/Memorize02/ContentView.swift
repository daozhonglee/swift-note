//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
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
struct CardView: View {
    var isFaceUp: Bool = false

    var body: some View {
        ZStack(content: {
            if isFaceUp{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(lineWidth: 2)
            Text("👿").font(.largeTitle)
            }else{
                //当我没有指定 CardView 上的颜色时，上面的橙色实际上会一直渗透到 CardView 中，这是因为 SwiftUI 会将视图的前景色传递给它的子视图
                RoundedRectangle(cornerRadius: 12)
            }
        })
    }
}

#Preview {
    ContentView()
}
