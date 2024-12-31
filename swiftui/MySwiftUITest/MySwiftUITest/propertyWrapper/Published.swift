//
//  Published.swift
//  MySwiftUITest
//
//  Created by zhihu on 27/12/2024.
//

// @Published 用于标记一个属性，使其成为可观察的。当这个属性的值发生变化时，SwiftUI 会自动通知所有依赖于该属性的视图进行更新
// @Published 与 @ObservedObject、@StateObject 或 @EnvironmentObject 等其他属性包装器结合使用，可以实现更简洁的数据绑定和状态管理

import SwiftUI

struct PublishedView: View {
    @StateObject private var viewModel = CounterViewModel()

      var body: some View {
          VStack {
              Text("Count: \(viewModel.count)")
                  .font(.largeTitle)
              Button("Increment") {
                  viewModel.increment()
              }
              .padding()
          }
          .padding()
      }
}

class CounterViewModel: ObservableObject {
    //每当 count 改变时，它会自动通知所有观察者
    @Published var count: Int = 0
    
    func increment() {
        count += 1
    }
}

#Preview {
    PublishedView()
}
