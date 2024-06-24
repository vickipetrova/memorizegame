//
//  memorizegameApp.swift
//  memorizegame
//
//  Created by Victoria Petrova on 24/06/2024.
//

import SwiftUI

@main
struct memorizegameApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
