//
//  LootDetailView.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

import SwiftUI

struct LootDetailView: View {
    let item: LootItem
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            Color.white
                .frame(height: item.rarity == .unique ? 400 : 330)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .center, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(item.rarity.showColor())
                                .frame(width: 120, height: 120)
                                .shadow(color: item.rarity.showColor().opacity(0.5), radius: 20, x: 0, y: 10)
                            
                            Text(item.type.showEmoji())
                                .font(.system(size: 60))
                        }
                        .padding(.top, 40)
                        
                        Text(item.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(item.rarity.showColor())
                        
                        if item.rarity == .unique {
                            Text("Item Unique 🏆")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 110)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.red)
                                )
                                .frame(maxWidth: .infinity)
                        }

                        
                        Spacer()
                            .frame(height: 20)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("INFORMATIONS")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        VStack(spacing: 0) {
                            InfoRow {
                                HStack {
                                    if let coverName = item.game.coverName,
                                        let _ = UIImage(named: coverName) {
                                            Image(coverName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 58)
                                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                        } else {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [.gray.opacity(0.4), .gray.opacity(0.4)],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                                .frame(width: 45, height: 58)
                                            
                                            Image(systemName: "rectangle.slash")
                                                .foregroundColor(.black)
                                                .opacity(0.4)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 12)
                                        }
                                    }
                                                                
                                    Text(item.game.name)
                                    }
                                }
                            
                            Divider()
                            
                            InfoRow {
                                Text("In-game : \(item.name)")
                            }
                            
                            Divider()
                            
                            if let attack = item.attackStrength {
                                InfoRow {
                                    Text("Puissance (ATQ) : \(attack)")
                                }
                                Divider()
                            }
                            
                            InfoRow {
                                Text("Possédé(s) : \(item.quantity)")
                            }
                            
                            Divider()
                            
                            InfoRow {
                                Text("Rareté : \(String(describing: item.rarity).capitalized)")
                            }
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        HStack {
            content()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        LootDetailView(item: lootItems[0])
    }
}
