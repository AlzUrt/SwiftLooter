//
//  EditItemView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI
import PhotosUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var inventory: Inventory
    let originalItem: LootItem
    
    @State private var name: String
    @State private var quantity: Int
    @State private var type: ItemType
    @State private var rarity: Rarity
    @State private var attackStrength: Int?
    @State private var game: Game
    @State private var isAttackItem: Bool
    @State private var hasCustomImage: Bool
    @State private var customImage: Data?
    @State private var selectedItem: PhotosPickerItem?
    private let isWishList: Bool
    
    init(item: LootItem) {
        self.originalItem = item
        self.isWishList = item.isWishList
        _name = State(initialValue: item.name)
        _quantity = State(initialValue: item.quantity)
        _type = State(initialValue: item.type)
        _rarity = State(initialValue: item.rarity)
        _attackStrength = State(initialValue: item.attackStrength)
        _game = State(initialValue: item.game)
        _isAttackItem = State(initialValue: item.attackStrength != nil)
        _hasCustomImage = State(initialValue: item.customImage != nil)
        _customImage = State(initialValue: item.customImage)
    }
    
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
                        Stepper("Force d'attaque: \(attackStrength ?? 1)", value: Binding(
                            get: { attackStrength ?? 1 },
                            set: { attackStrength = $0 }
                        ), in: 1...99)
                    }
                }
                
                Section {
                    Toggle("Image personnalisée", isOn: $hasCustomImage)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    if hasCustomImage {
                        PhotosPicker(selection: $selectedItem,
                                   matching: .images) {
                            if let customImage, let uiImage = UIImage(data: customImage) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 200)
                            } else {
                                Label("Sélectionner une image", systemImage: "photo")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Modifier l'objet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
                        let updatedItem = LootItem(
                            id: originalItem.id,
                            quantity: quantity,
                            name: name,
                            type: type,
                            rarity: rarity,
                            attackStrength: isAttackItem ? (attackStrength ?? 1) : nil,
                            game: game,
                            customImage: hasCustomImage ? customImage : nil,
                            isWishList: isWishList
                        )
                        inventory.updateItem(updatedItem)
                        dismiss()
                    }
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        customImage = data
                    }
                }
            }
            .onChange(of: hasCustomImage) { oldValue, newValue in
                if !newValue {
                    customImage = nil
                    selectedItem = nil
                }
            }
            .onChange(of: isAttackItem) { oldValue, newValue in
                if newValue && attackStrength == nil {
                    attackStrength = 1
                } else if !newValue {
                    attackStrength = nil
                }
            }
        }
    }
}

#Preview {
    EditItemView(item: LootItem.emptyItem)
        .environmentObject(Inventory())
}
