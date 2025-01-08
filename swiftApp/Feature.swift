//
//  Feature.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct Feature: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let tag: Int
    
    static let features: [Feature] = [
        Feature(
            title: "Gérez votre inventaire",
            subtitle: "Gardez une trace de tous vos objets de jeu au même endroit",
            image: "backpack.fill",
            tag: 1
        ),
        Feature(
            title: "Organisez par rareté",
            subtitle: "Classez vos objets selon leur niveau de rareté pour mieux les retrouver",
            image: "star.fill",
            tag: 2
        ),
        Feature(
            title: "Multi-jeux",
            subtitle: "Gérez les objets de tous vos jeux préférés",
            image: "gamecontroller.fill",
            tag: 3
        )
    ]
}
