//
//  LootDetailView.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

import SwiftUI

struct LootDetailView: View {
    @State private var isRotating = false
    @State private var isShadowAnimating = false
    @State private var showContent = false
    @State private var showUniqueBadge = false
    @State private var showInfo = false
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
                                .shadow(
                                    color: item.rarity.showColor().opacity(0.5),
                                    radius: isShadowAnimating ? 100.0 : 0,
                                    x: 0,
                                    y: 10
                                )
                                .animation(.bouncy.delay(0.6), value: isShadowAnimating)
                            
                            Text(item.type.showEmoji())
                                .font(.system(size: 60))
                        }
                        .scaleEffect(showContent ? 1 : 0.5)
                        .rotation3DEffect(
                            .degrees(isRotating ? 360 : 0),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .animation(
                            .spring(
                                response: 1,
                                dampingFraction: 0.8,
                                blendDuration: 0
                            ).delay(0.4),
                            value: isRotating
                        )
                        .animation(
                            .spring(response: 0.6).delay(0.4),
                            value: showContent
                        )
                        .padding(.top, 40)
                        
                        Text(item.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(item.rarity.showColor())
                            .opacity(showContent ? 1 : 0)
                            .offset(y: showContent ? 0 : 20)
                            .animation(.spring(response: 0.6).delay(0.6), value: showContent)
                        
                        if item.rarity == .unique {
                            Text("Item Unique 🏆")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 110)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.red)
                                        .shadow(radius: showUniqueBadge ? 10 : 0)
                                )
                                .scaleEffect(showUniqueBadge ? 1 : 0.8)
                                .opacity(showUniqueBadge ? 1 : 0)
                                .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.8), value: showUniqueBadge)
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
                            .opacity(showInfo ? 1 : 0)
                            .offset(x: showInfo ? 0 : -20)
                            .animation(.easeOut.delay(1), value: showInfo)
                        
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
                                            .opacity(showInfo ? 1 : 0)
                                            .animation(.easeOut.delay(1.2), value: showInfo)
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
                                        .opacity(showInfo ? 1 : 0)
                                        .animation(.easeOut.delay(1.2), value: showInfo)
                                }
                            }
                            
                            Divider()
                                .opacity(showInfo ? 1 : 0)
                                .animation(.easeOut.delay(1.3), value: showInfo)
                            
                            InfoRow {
                                Text("In-game : \(item.name)")
                                    .opacity(showInfo ? 1 : 0)
                                    .offset(x: showInfo ? 0 : 20)
                                    .animation(.easeOut.delay(1.4), value: showInfo)
                            }
                            
                            Divider()
                                .opacity(showInfo ? 1 : 0)
                                .animation(.easeOut.delay(1.5), value: showInfo)
                            
                            if let attack = item.attackStrength {
                                InfoRow {
                                    Text("Puissance (ATQ) : \(attack)")
                                        .opacity(showInfo ? 1 : 0)
                                        .offset(x: showInfo ? 0 : 20)
                                        .animation(.easeOut.delay(1.6), value: showInfo)
                                }
                                Divider()
                                    .opacity(showInfo ? 1 : 0)
                                    .animation(.easeOut.delay(1.7), value: showInfo)
                            }
                            
                            InfoRow {
                                Text("Possédé(s) : \(item.quantity)")
                                    .opacity(showInfo ? 1 : 0)
                                    .offset(x: showInfo ? 0 : 20)
                                    .animation(.easeOut.delay(1.8), value: showInfo)
                            }
                            
                            Divider()
                                .opacity(showInfo ? 1 : 0)
                                .animation(.easeOut.delay(1.9), value: showInfo)
                            
                            InfoRow {
                                Text("Rareté : \(String(describing: item.rarity).capitalized)")
                                    .opacity(showInfo ? 1 : 0)
                                    .offset(x: showInfo ? 0 : 20)
                                    .animation(.easeOut.delay(2.0), value: showInfo)
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
        .task {
            try? await Task.sleep(for: .seconds(0.4))
            withAnimation {
                showContent = true
                isRotating = true
            }
            
            try? await Task.sleep(for: .seconds(0.2))
            withAnimation {
                isShadowAnimating = true
            }
            
            try? await Task.sleep(for: .seconds(0.2))
            withAnimation {
                showUniqueBadge = true
            }
            
            try? await Task.sleep(for: .seconds(0.2))
            withAnimation {
                showInfo = true
            }
        }
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
