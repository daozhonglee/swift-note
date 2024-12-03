//
//  Memorize02App.swift
//  Memorize02
//
//  Created by shanquan on 2024/11/24.
//

import SwiftUI

@main
struct Memorize02App: App {
    var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryView(viewModel: game)
        }
    }
}
