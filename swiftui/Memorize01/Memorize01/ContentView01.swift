//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//

import SwiftUI

struct ContentView01: View {
    //这是个计算属性，body 是结构体的属性
    //计算属性是计算出来的，每次有人获取 body 的值时，就会运行这段代码
    // var 表示他时个变量，每次计算都有可能不一样
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .foregroundColor(Color.blue)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
