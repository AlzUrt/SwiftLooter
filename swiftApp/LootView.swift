//
//  LootView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct LootView: View {
    @EnvironmentObject var inventory: Inventory
    @State var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            ItemListView(isWishList: false, showAddItemView: $showAddItemView)
        }
    }
}
