//
//  Memorize04App.swift
//  Memorize04
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

@main
struct Memorize04App: App {
    //@StateObject 用于在 SwiftUI 应用程序的生命周期内维护对象状态的持久性. 与 @State 不同，@StateObject 用于在整个应用程序生命周期内保持对象的持久性，而不是在视图生命周期内保持对象的持久性
    // @StateObject 确保对象只被创建一次
    // 第一次创建应用时初始化 game 对象, 即使视图重新加载，game 实例也会保持, 所有使用此 game 的视图都会共享同一个实例
    // 使用场景
    //  在 App 或 Scene 级别创建共享数据模型
    //  需要在整个应用程序中保持状态的情况
    //  作为单一数据源使用的视图模型
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMomoryGameView(viewModel: game)
        }
    }
}
