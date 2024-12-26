//
//  ToolBarItemView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/27.
//

import SwiftUI

struct ToolBarItemView: View {
    var body: some View {
        NavigationView {
            Text("内容")
                .toolbar {
                    // 1. 基本用法
                    ToolbarItem(placement: .primaryAction) {
                        Button("添加") { }
                    }

                    // 2. 取消按钮位置
                    ToolbarItem(placement: .cancellationAction) {
                        Button("取消") { }
                    }

                    // 3. 导航栏主要位置
                    ToolbarItem(placement: .principal) {
                        Text("标题")
                    }


                    ToolbarItem(placement: .topBarLeading) {
                        Button("111") { }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("222") { }
                    }
                    ToolbarItem(placement: .destructiveAction) {
                        Button("2233332") { }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("22bd2") { }
                    }
                    // 4. 底部工具栏
                    ToolbarItem(placement: .bottomBar) {
                        Button("底部按钮") { }
                    }

                }
        }
    }
}
#Preview {
    ToolBarItemView()
}
