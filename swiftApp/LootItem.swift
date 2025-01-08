
//
//  LootItem.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

import SwiftUI

enum ItemType: CaseIterable {
    case magic
    case fire
    case ice
    case wind
    case poison
    case thunder
    case dagger
    case shield
    case bow
    case ring
    case unknown

    func showEmoji() -> String {
        switch self {
        case .magic:
            return "⭐️"
        case .fire:
            return "🔥"
        case .ice:
            return "❄️"
        case .wind:
            return "💨"
        case .poison:
            return "☠️"
        case .thunder:
            return "⚡️"
        case .dagger:
            return "🗡️"
        case .shield:
            return "🛡️"
        case .bow:
            return "🏹"
        case .ring:
            return "💍"
        case .unknown:
            return "🎲"
        }
    }

    func showName() -> String {
        switch self {
        case .magic:
            return "Magic"
        case .fire:
            return "Fire"
        case .ice:
            return "Ice"
        case .wind:
            return "Wind"
        case .poison:
            return "Poison"
        case .thunder:
            return "Thunder"
        case .dagger:
            return "Dagger"
        case .shield:
            return "Shield"
        case .bow:
            return "Bow"
        case .ring:
            return "Ring"
        case .unknown:
            return "Unknown"
        }
    }
}

struct LootItem: Identifiable {
    var id: UUID = UUID()
    var quantity: Int = 1
    var name: String = ""
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
    var customImage: Data?
    var isWishList: Bool = false
    
    static var emptyItem = LootItem(quantity: 1, name: "", type: .fire, rarity: .common, attackStrength: 0, game: availableGames[1], isWishList: false)
    static var emptyWishListItem = LootItem(quantity: 1, name: "", type: .fire, rarity: .common, attackStrength: 0, game: availableGames[1], isWishList: true)
}

var lootItems = [
    LootItem(quantity: 1, name: "Flame Sword", type: .fire, rarity: .epic, attackStrength: 50, game: availableGames[1], isWishList: false),
    LootItem(quantity: 1, name: "Ice Staff", type: .ice, rarity: .rare, attackStrength: 30, game: availableGames[1], isWishList: false),
    LootItem(quantity: 1, name: "Thunder Bow", type: .thunder, rarity: .legendary, attackStrength: 40, game: availableGames[1], isWishList: false),
    LootItem(quantity: 1, name: "Magic Ring", type: .magic, rarity: .common, attackStrength: nil, game: availableGames[1], isWishList: false),
    LootItem(quantity: 1, name: "Poison Dagger", type: .poison, rarity: .rare, attackStrength: 25, game: availableGames[1], isWishList: true),
    LootItem(quantity: 1, name: "Wind Shield", type: .wind, rarity: .unique, attackStrength: nil, game: availableGames[1], isWishList: true)
]

//#Preview {
//    LootItem()
//}
