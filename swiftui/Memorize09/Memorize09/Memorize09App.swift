//
//  Memorize09App.swift
//  Memorize09
//
//  Created by shanquan on 2024/12/11.
//

import SwiftUI

@main
struct Memorize09App: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
