//
//  WishListView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct WishListView: View {
    @EnvironmentObject var inventory: Inventory
    @State private var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            NavigationStack {
                ItemListView(isWishList: true, showAddItemView: $showAddItemView)
            }
        }
    }
}
