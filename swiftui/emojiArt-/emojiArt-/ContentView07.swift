//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
//  把列改造成网格

import SwiftUI

struct ContentView7: View {
    let emojis0: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐"]
    //数组的简写
    let emojis: [String] = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]
    @State var cardCount:Int = 4

    var body: some View {
        //hstack 有 viewBuilder修饰, 里面不能使用 for 循环
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusts
        }
        .padding()
    }

    //!!!
    var cards: some View {
        // LazyVGrid 是 SwiftUI 中用于创建垂直网格布局的视图容器
        // 懒加载：顾名思义，LazyVGrid 采用懒加载机制，只有当内容即将出现在屏幕上时才会被创建
        // 垂直方向：内容在垂直方向上滚动，网格项按列排列
        // 自适应布局：可以根据屏幕尺寸自动调整列数和大小
        // 相比普通的 VStack 或 HStack，LazyVGrid 更适合展示类似照片墙、商品列表等网格式布局的内容。
        // adaptive 系统会根据这些参数自动计算可以放置的列数 minimum 列的最小宽度
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            //foreach 可以创建视图
            ForEach(0..<cardCount, id: \.self) { index in
                CardView7(content: emojis[index])
                // aspectRatio 是 SwiftUI 中用于控制视图宽高比的重要修饰符
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjusts: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.headline)
    }

    func cardcountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                cardCount += offset
            },
            label: {
                Text(Image(systemName: symbol))
            })
        .disabled(cardCount+offset<1 || cardCount+offset>emojis.count)
    }

    var cardRemover: some View {
        cardcountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        cardcountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView7: View {
    let content: String
    @State var isFaceUp = true

    //!!!
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            //opacity 透明度,这里不用 if-else 的原因是如果没有 text，则卡片会被压缩的很小
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            debugPrint("tapped")
            isFaceUp.toggle()
        }
        // 视图前景色
        .foregroundColor(.orange)
    }
}

#Preview {
    ContentView7()
}
