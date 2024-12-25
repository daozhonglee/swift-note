//
//  Memorize08App.swift
//  Memorize08
//
//  Created by shanquan on 2024/12/10.
//

import SwiftUI

@main
struct Memorize08App: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMomoryGameView(viewModel: game)
        }
    }
}
