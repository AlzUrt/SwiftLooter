//
//  swiftAppApp.swift
//  swiftApp
//
//  Created by MAZEL Florian on 08/10/2024.
//

import SwiftUI

@main
struct swiftAppApp: App {
    @AppStorage("isOnboardingDone") private var isOnboardingDone: Bool = false
    @StateObject private var inventory = Inventory()
    
    var body: some Scene {
        WindowGroup {
            if isOnboardingDone {
                ContentView()
                    .environmentObject(inventory)
            } else {
                OnboardingView()
            }
        }
    }
}
