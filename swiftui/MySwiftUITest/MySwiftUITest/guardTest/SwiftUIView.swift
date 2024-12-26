//
//  SwiftUIView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/27.
//

import SwiftUI

//guard 的好处
//  提前验证条件并退出
//  优雅地处理可选值解包
//  减少代码嵌套层级
struct SwiftUIView: View {
    @State private var guardVar: Int?
    var body: some View {
        Text("Hello, World! \(getGuardVar())")
    }
    func getGuardVar() -> Int {
        guard let guardVar = guardVar else {return 0}
        return guardVar
    }
    //if 写法
    func getWithIf()->Int{
        if let v = guardVar {
            return v
        } else {
            return 0
        }
    }
}

#Preview {
    SwiftUIView()
}
