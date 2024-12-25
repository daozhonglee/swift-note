//
//  Memorize04App.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

@main
struct Memorize05App: App {
    // 在 App 级别使用 @StateObject，表示该对象的生命周期是应用程序的生命周期
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMomoryGameView(viewModel: game)
        }
    }
}
