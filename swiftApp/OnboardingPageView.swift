//
//  OnboardingPageView.swift
//  swiftApp
//
//  Created by Amaury Chabert on 08/01/2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let feature: Feature
    @Binding var currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: feature.image)
                .font(.system(size: 80))
                .foregroundStyle(.blue)
                .padding()
                .background(
                    Circle()
                        .fill(.blue.opacity(0.2))
                        .frame(width: 160, height: 160)
                )
            
            Text(feature.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(feature.subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 32)
            
            Spacer()
            
            if feature.tag == totalSteps {
                Button(action: {
                    withAnimation {
                        UserDefaults.standard.set(true, forKey: "isOnboardingDone")
                    }
                }) {
                    Text("Commencer")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 20)
                }
            } else {
                Button(action: {
                    withAnimation {
                        currentStep += 1
                    }
                }) {
                    Text("Suivant")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 20)
                }
            }
            
            Spacer().frame(height: 20)
        }
        .tag(feature.tag)
    }
}

#Preview {
    OnboardingPageView(feature: Feature.features[0], currentStep: .constant(1), totalSteps: 3)
        .preferredColorScheme(.light)
        .previewDisplayName("Light Mode")
}

#Preview {
    OnboardingPageView(feature: Feature.features[2], currentStep: .constant(3), totalSteps: 3)
        .preferredColorScheme(.dark)
        .previewDisplayName("Dark Mode")
}
