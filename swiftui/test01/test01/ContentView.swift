//
//  ContentView.swift
//  test01
//
//  Created by shanquan on 2024/11/20.
//

import SwiftUI

struct ContentView: View {
    //some View 告诉编译器这个方法返回的是某个遵循 View 协议的具体类型 使用 some 关键字可以隐藏具体的返回类型，同时保持类型信息的完整性
    var body: some View {
        // vstask 是一个函数，并且content 参数是一个 tupleView（视图 tuple）
        // vstask 的简写形式可以认为是在获取视图 tuple view， 所以 vstack 中不能写逻辑，只能放视图列表
        // VStack(content: {    return TupleView( (Text("Hello"), Text("World"))
        // vstask 的简写形式也叫 viewbuilder
        
        VStack (alignment:.leading, spacing: 20, content:{
            Image(systemName: "globe")
                .imageScale(.large) // 图片大小
                .foregroundStyle(.tint) // 前景色
            Text("Hello, world!")
                .padding()
        })
        .padding()
        .font(.largeTitle)
        
    }
}

#Preview {
    ContentView()
}
