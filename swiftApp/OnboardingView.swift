//
//  OnboardingView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 1
    private let totalSteps = 3
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(Feature.features) { feature in
                OnboardingPageView(
                    feature: feature,
                    currentStep: $currentStep,
                    totalSteps: totalSteps
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .animation(.default, value: currentStep)
    }
}

#Preview {
    OnboardingView()
}
