//
//  MemorizeApp.swift
//  Memorize
//
//  Created by shanquan on 2024/11/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject  var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryView(viewModel: game)
        }
    }
}
