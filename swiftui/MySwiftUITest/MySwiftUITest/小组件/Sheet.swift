//
//  Sheet.swift
//  MySwiftUITest
//
//  Created by zhihu on 27/12/2024.
//

import SwiftUI

// .sheet 修饰器用于在当前视图之上显示一个模态视图，通常用于需要用户交互的场景。通过绑定布尔值控制显示和隐藏，并在关闭时执行回调函数。
// .sheet 修饰器可以在任何遵循 View 协议的视图上使用
// 参数解释
// isPresented:

//绑定到一个布尔值 isAddingSymbol，控制 sheet 的显示和隐藏。
//当 isAddingSymbol 为 true 时，sheet 会显示；为 false 时，sheet 会隐藏。
//onDismiss:
//
//当 sheet 被关闭时调用的回调函数。
//在这里，addSymbol 方法会在 sheet 关闭时被调用。
//content:
//
//闭包中定义了要显示的视图内容。
//在这里，SymbolPicker 视图会在 sheet 中显示，并绑定到 selectedSymbol。

struct Sheet: View {
    @State var showSheet: Bool = false

    var body: some View {

        VStack{
            HStack {
                Button("Show Sheet") {
                    showSheet = false
                }
            }
            Divider()

            VStack {
                staskSheet()
                Divider()
                buttonSheet()
            }
        }

    }
    // 在 button 上使用.sheet
    func buttonSheet() -> some View {
        Button("Show Sheet") {
            showSheet = true
        }
        .frame(height: 100)
        .padding()
        .background(Color.green)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.red, lineWidth: 2)
        )
        .sheet(isPresented: $showSheet) {
            Text("This is a sheet")
                .frame(height: 300)
        }
    }

    // 在 stask 上使用.sheet
    func staskSheet() -> some View {
        VStack {
            Text("staskSheet").font(.largeTitle)
        }
        .padding()
        .background(Color.green)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.red, lineWidth: 2)
        )
        .sheet(isPresented: $showSheet, onDismiss: dissmissAction) {
            Text("This is a sheet")
                .frame(height: 300)
        }
    }

    func dissmissAction() {
        showSheet = false
    }

}

#Preview {
    Sheet()
}
