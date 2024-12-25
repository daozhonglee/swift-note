//
//  Memorize06App.swift
//  Memorize06
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

@main
struct Memorize06App: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMomoryGameView(viewModel: game)
        }
    }
}
