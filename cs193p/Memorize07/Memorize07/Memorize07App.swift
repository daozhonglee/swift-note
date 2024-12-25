//
//  Memorize07App.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/9.
//

import SwiftUI

@main
struct Memorize07App: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMomoryGameView(viewModel: game)
        }
    }
}
