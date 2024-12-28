//
//  GeometryReaderView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/28.
//

import SwiftUI
//GeometryReader 是 SwiftUI 中的一个视图容器，用于获取其父视图或自身的大小和位置信息。它允许你根据视图的几何信息（如尺寸、坐标等）动态调整子视图的布局或行为。GeometryReader 是构建自适应和响应式 UI 的强大工具。
//GeometryReader 的基本用法
//GeometryReader 是一个视图容器，它会将其子视图的内容包裹在一个闭包中，并提供一个 GeometryProxy 参数。通过 GeometryProxy，你可以访问以下信息：
//  size：父视图或 GeometryReader 本身的大小（CGSize）。
//
//  safeAreaInsets：安全区域的边距（EdgeInsets）。
//
//  frame(in:)：获取视图在特定坐标系中的位置和大小（CGRect）。

struct GeometryReaderView: View {
    var body: some View {
        getGeometryReader()
        adjustWidthHeight()
        getSafeArea()
        getViewPosition()
    }

    //获取视图的大小
    func getGeometryReader() -> some View {
        GeometryReader { geometry in
            VStack {
                Text("宽度: \(geometry.size.width)")
                Text("高度: \(geometry.size.height)")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.blue.opacity(0.2))
        }
        .padding()
    }

    //根据大小动态调整布局
    func adjustWidthHeight() -> some View {
        GeometryReader { geometry in
            if geometry.size.width > 300 {
                HStack {
                    Text("宽屏布局")
                    Image(systemName: "desktopcomputer")
                }
            } else {
                VStack {
                    Text("窄屏布局")
                    Image(systemName: "iphone")
                }
            }
        }
        .padding()
        .background(Color.green.opacity(0.2))
    }

    //获取安全区域
    func getSafeArea() -> some View {
        GeometryReader { geometry in
            VStack {
                Text("顶部安全区域: \(geometry.safeAreaInsets.top)")
                Text("底部安全区域: \(geometry.safeAreaInsets.bottom)")
            }
            .padding()
            .background(Color.orange.opacity(0.2))
        }
    }

    //获取获取视图在全局坐标系中的位置
    func getViewPosition() -> some View {
        VStack {
            GeometryReader { geometry in
                Text(
                    "视图位置: \(geometry.frame(in: .global).origin.x), \(geometry.frame(in: .global).origin.y)"
                )
                .padding()
                .background(Color.purple.opacity(0.2))
            }
        }
        .padding()

    }
}

#Preview {
    GeometryReaderView()
}
