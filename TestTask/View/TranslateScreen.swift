//
//  MainScreen.swift
//  TestTask
//
//  Created by Roman Khancha on 06.02.2025.
//

import SwiftUI

struct TranslateScreen: View {
    
    @State private var animalState: AnimalState = .dog
    @State private var translatorSwitch = false
    @State private var microphonePressed = false
    @State private var translationProcessing = false
    @State private var navigateToResult = false
    @State private var succseedTranslation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                content
            }
            .foregroundStyle(.testTaskBlack)
            .fontWeight(.bold)
            .fullScreenCover(isPresented: $navigateToResult) {
                ResultScreen(animalState: $animalState, succseedTranslation: $succseedTranslation)
            }
        }
    }
}

extension TranslateScreen {
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [.testTaskWhite, .testTaskLiteGreen], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    private var content: some View {
        VStack(spacing: 58) {
            if translationProcessing {
                processingText
            } else {
                VStack(spacing: 58) {
                    header
                    mainButtons
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            
            animalImage
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.vertical, 12)
    }
    
    private var processingText: some View {
        Text("Process of translation...")
            .font(.title3)
            .multilineTextAlignment(.center)
    }
    
    private var animalImage: some View {
        Image(animalState == .cat ? "cat" : "dog")
            .resizable()
            .frame(width: 184, height: 184)
    }
    
    private var header: some View {
        VStack(spacing: 16) {
            Text("Translate")
                .font(.system(size: 32))
            
            languageSwitch
        }
    }
    
    private var languageSwitch: some View {
        HStack(alignment: .center, spacing: 40) {
            languageLabel(for: translatorSwitch ? "PET" : "HUMAN")
            swapIcon
            languageLabel(for: translatorSwitch ? "HUMAN" : "PET")
        }
    }
    
    private func languageLabel(for text: String) -> some View {
        Text(text)
            .frame(width: 80)
            .padding(16)
    }
    
    private var swapIcon: some View {
        Image("arrow-swap-horizontal")
            .foregroundStyle(.testTaskBlack)
            .onTapGesture { translatorSwitch.toggle() }
    }
    
    private var mainButtons: some View {
        HStack(spacing: 35) {
            MicrophoneButton(microphonePressed: $microphonePressed) {
                startTranslation()
            }
            
            AnimalSelectionView(selectedAnimal: $animalState)
        }
    }
}

extension TranslateScreen {
    private func startTranslation() {
        translationProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            translationProcessing = false
            succseedTranslation = translatorSwitch
            navigateToResult = true
        }
    }
}
