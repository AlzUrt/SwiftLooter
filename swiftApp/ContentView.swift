//
//  ContentView.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

//import SwiftUI
//
//class Inventory: ObservableObject {
//    @Published var loot = ["Epée", "Bouclier", "Armure"]
//    
//    func addItem(item: String) {
//        loot.append(item)
//    }
//}
//
//struct ContentView: View {
//    @StateObject var inventory = Inventory()
//
//    @State var showAddItemView = false
//    
////    @EnvironmentObject var inventoryLoot: Inventory
//
//    var body: some View {
//        NavigationStack {
//            List {
//                Button(action: {
//                    inventory.addItem(item: "Magie de feu")
//                }, label: {
//                    Text("Ajouter")
//                })
//                ForEach(inventory.loot, id: \.self) { item in
//                    Text(item)
//                }
//            }
//            .sheet(isPresented: $showAddItemView, content: {
//                    AddItemView().environmentObject(inventory)
//                })
//            .navigationBarTitle("Loot") // Notre titre de page, choisissez le titre que vous voulez
//                .toolbar(content: { // La barre d'outil de notre page
//                    ToolbarItem(placement: ToolbarItemPlacement.automatic) {
//                        Button(action: {
//                            showAddItemView.toggle() // L'action de notre bouton
//                        }, label: {
//                            Image(systemName: "plus.circle.fill")
//                        })
//                    }
//                })
//            List {
//                ForEach(inventory.loot, id: \.self) { item in
//                    Text(item)
//                }
//            }
//        }
//        .environmentObject(inventory)
//
//    }
//}
//
//#Preview {
//    ContentView()
//}

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
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.items) { item in
                    NavigationLink(destination: LootDetailView(item: item)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .fill(Color(item.rarity.showColor()))
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
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView().environmentObject(inventory)
            })
            .navigationBarTitle("Loot")
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
        .environmentObject(inventory)
    }
}

#Preview {
    ContentView()
}
