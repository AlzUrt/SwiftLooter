//
//  ContentView.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var items: [LootItem] = []
    
    init() {
        // Populate items directly in init
        items = lootItems
    }
    
    func addItem(_ item: LootItem) {
        items.append(item)
    }
    
    func deleteItem(at offsets: IndexSet, isWishList: Bool) {
        let filteredIndices = items.indices.filter { items[$0].isWishList == isWishList }
        let toDelete = offsets.map { filteredIndices[$0] }
        items.remove(atOffsets: IndexSet(toDelete))
    }
    
    func updateItem(_ updatedItem: LootItem) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        }
    }
    
    func filteredItems(isWishList: Bool) -> [LootItem] {
        items.filter { $0.isWishList == isWishList }
    }
}

import SwiftUI

struct ContentView: View {
    @StateObject private var inventory = Inventory()
    @State private var selectedFeature: LooterFeature = .loot
    @AppStorage("isOnboardingDone") private var isOnboardingDone: Bool = false
    
    var body: some View {
        TabView(selection: $selectedFeature) {
            LootView()
                .tabItem {
                    Label("Loot", systemImage: "bag.fill")
                }
                .tag(LooterFeature.loot)
            
            WishListView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }
                .tag(LooterFeature.wishList)
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
                .tag(LooterFeature.profile)
        }
        .environmentObject(inventory)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isOnboardingDone")
                }, label: {
                    Image(systemName: "arrow.counterclockwise")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
