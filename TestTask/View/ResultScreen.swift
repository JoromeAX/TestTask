//
//  ResultScreen.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI

struct ResultScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var animalState: AnimalState
    @Binding var succseedTranslation: Bool
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack(spacing: 32) {
                header
                Spacer()
                resultMessage
                Spacer()
                animalImage
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 164)
        }
        .foregroundStyle(.testTaskBlack)
    }
}

extension ResultScreen {
    private var backgroundGradient: some View {
        LinearGradient(colors: [.testTaskWhite, .testTaskLiteGreen], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
    private var header: some View {
        HStack {
            closeButton
            Spacer()
            Text("Result")
                .font(.system(size: 32))
                .bold()
            Spacer()
            closeButton.opacity(0)
        }
        .padding(.top, 12)
    }
    
    private var closeButton: some View {
        Circle()
            .frame(width: 48, height: 48)
            .foregroundStyle(.white)
            .overlay {
                Image("close")
            }
            .onTapGesture {
                dismiss()
            }
    }
    
    private var resultMessage: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 291, height: succseedTranslation ? 142 : 54)
            .foregroundStyle(.testTaskLitePurple)
            .overlay {
                if succseedTranslation {
                    Text(animalState == .cat ? "I’m hungry, feed me!" : "What are you doing, human?")
                        .fontWeight(.bold)
                } else {
                    HStack(spacing: 12) {
                        Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                        Text("Repeat")
                            .fontWeight(.bold)
                    }
                    .onTapGesture {
                        dismiss()
                    }
                }
            }
    }
    
    private var animalImage: some View {
        Image(animalState == .cat ? "cat" : "dog")
            .resizable()
            .frame(width: 184, height: 184)
    }
}
