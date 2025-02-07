//
//  AnimalSelectionView.swift
//  TestTask
//
//  Created by Roman Khancha on 06.02.2025.
//

import SwiftUI

struct AnimalSelectionView: View {
    @Binding var selectedAnimal: AnimalState
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: UIConstants.buttonCornerRadius)
                .frame(width: UIConstants.smallButtonSize.width, height: UIConstants.smallButtonSize.height)
                .foregroundStyle(.white)
                .shadow(radius: UIConstants.buttonShadow, y: UIConstants.buttonShadow)
            
            VStack {
                animalButton(animal: .cat, color: .testTaskLiteBlue, imageName: "cat")
                animalButton(animal: .dog, color: .testTaskLemon, imageName: "dog")
            }
        }
    }
    
    private func animalButton(animal: AnimalState, color: Color, imageName: String) -> some View {
        RoundedRectangle(cornerRadius: UIConstants.buttonCornerRadius)
            .frame(width: UIConstants.buttonSize.width, height: UIConstants.buttonSize.height)
            .foregroundStyle(color)
            .overlay {
                Image(imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            .opacity(selectedAnimal == animal ? 1 : 0.6)
            .onTapGesture {
                selectedAnimal = animal
            }
    }
}

enum AnimalState {
    case cat, dog
}
