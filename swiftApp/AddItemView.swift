//
//  AddItemView.swift
//  swiftApp
//
//  Created by MAZEL Florian on 13/11/2024.
//

import SwiftUI

enum Rarity : CaseIterable {
    case common
    case uncommon
    case rare
    case epic
    case legendary
    case unique
    
    func showColor() -> Color {
        switch self {
        case .common:
            return .gray
        case .uncommon:
            return .green
        case .rare:
            return .blue
        case .epic:
            return .purple
        case .legendary:
            return .orange
        case .unique:
            return .yellow
        }
    }
}


struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var inventory: Inventory
    let isWishList: Bool
    
    @State private var name = ""
    @State private var rarity: Rarity = .common
    @State private var game: Game = .emptyGame
    @State private var type: ItemType = .magic
    @State private var quantity: Int = 1
    @State private var isAttackItem: Bool = false
    @State private var attackStrength: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nom de l'objet", text: $name)
                    
                    Picker("Rareté", selection: $rarity) {
                        ForEach(Rarity.allCases, id: \.self) { rarity in
                            Text(String(describing: rarity).capitalized)
                        }
                    }
                }
                
                Section {
                    Picker("Jeu", selection: $game) {
                        Text("Non spécifié").tag(Game.emptyGame)
                        ForEach(availableGames) { game in
                            Text(game.name).tag(game)
                        }
                    }
                    
                    Stepper("Quantité: \(quantity)", value: $quantity, in: 1...99)
                }
                
                Section {
                    HStack {
                        Text("Type")
                        Spacer()
                        Text("\(type.showEmoji())")
                    }
                    
                    Picker("Type", selection: $type) {
                        ForEach(ItemType.allCases, id: \.self) { type in
                            Text(type.showEmoji())
                        }
                    }
                    .pickerStyle(.palette)
                }
                
                Section {
                    Toggle("Objet d'attaque ?", isOn: $isAttackItem)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    if isAttackItem {
                        Stepper("Force d'attaque: \(attackStrength)", value: $attackStrength, in: 1...99)
                    }
                }
                
                Section {
                    Button("Ajouter") {
                        let newItem = LootItem(
                            quantity: quantity,
                            name: name,
                            type: type,
                            rarity: rarity,
                            attackStrength: isAttackItem ? attackStrength : nil,
                            game: game,
                            isWishList: isWishList
                        )
                        
                        inventory.addItem(newItem)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle(isWishList ? "Ajouter à la wishlist" : "Ajouter un objet")
        }
    }
}

#Preview {
    AddItemView(isWishList: false)
        .environmentObject(Inventory())
}
