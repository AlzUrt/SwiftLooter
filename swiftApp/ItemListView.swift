//
//  ItemListView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var inventory: Inventory
    let isWishList: Bool
    @Binding var showAddItemView: Bool
    
    var body: some View {
        List {
            ForEach(inventory.filteredItems(isWishList: isWishList)) { item in
                NavigationLink(destination: LootDetailView(item: item)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .fill(item.rarity.showColor())
                                .frame(width: 20, height: 20)
                            Text(item.name)
                            Spacer()
                            Text(item.type.showEmoji())
                        }
                        
                        Text("Quantité : \(item.quantity)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete { offsets in
                inventory.deleteItem(at: offsets, isWishList: isWishList)
            }
        }
        .sheet(isPresented: $showAddItemView) {
            AddItemView(isWishList: isWishList).environmentObject(inventory)
        }
        .navigationTitle(isWishList ? "Wishlist" : "Loot")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    showAddItemView.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        ItemListView(isWishList: false, showAddItemView: .constant(false))
            .environmentObject(Inventory())
    }
}
