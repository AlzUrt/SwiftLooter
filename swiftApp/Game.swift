//
//  Game.swift
//  swiftApp
//
//  Created by MAZEL Florian on 13/11/2024.
//

import SwiftUI

enum GameGenre: CaseIterable {
    case mmorpg, rpg, looter, fps, tps, strategy, unset
}

struct Game: Identifiable, Hashable {

    let name: String
    let id: UUID = UUID()
    let genre: GameGenre
    let coverName : String?
    
    static var emptyGame = Game(name: "", genre: .unset, coverName: nil)
}

let availableGames = [
    Game(name: "Ultimate Chicken Horse", genre: .strategy, coverName: "uch"),
    Game(name: "Minecraft", genre: .fps, coverName: "mc"),
    Game(name: "Counter-Strike 2", genre: .fps, coverName: "cs2"),
    Game(name: "Bloons TD 6", genre: .strategy, coverName: "b6"),
    Game(name: "Mario & Luigi", genre: .looter, coverName: "ml")
]
