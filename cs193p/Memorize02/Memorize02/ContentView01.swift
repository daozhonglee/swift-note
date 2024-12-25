//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//
// 主要讲解了 RoundedRectangle圆角矩形视图, 
// onTapGesture 点击修饰符
// State  属性包装器 ，常量和变量的声明

import SwiftUI

struct ContentView01: View {
    var body: some View {
        HStack{
            CardView01()
            CardView01()
            CardView01()
            CardView01()
        }

        .foregroundColor(.orange)
        .padding()
    }
}
struct CardView01: View {
    //@State 是一个SwiftUI的属性包装器，用于管理视图的私有状态。
    // 它允许视图在其生命周期内存储和响应数据的变化
    // 为什么要加 state
    // @State 是 SwiftUI 提供的一种机制，用于在视图中声明可变状态。
    @State var isFaceUp: Bool = false

    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            if isFaceUp{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👿").font(.largeTitle)
            }else{
                //当我没有指定 CardView 上的颜色时，上面的橙色实际上会一直渗透到 CardView 中，这是因为 SwiftUI 会将视图的前景色传递给它的子视图
                base.fill()
            }
        }
        //onTapGesture 是一个用于检测用户点击事件的修饰符。
        // 它可以轻松地为视图添加点击手势，并执行相应的操作
        .onTapGesture(count: 1){
            isFaceUp.toggle()
        }

    }
}

#Preview {
    ContentView01()
}
