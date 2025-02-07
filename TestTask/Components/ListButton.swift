//
//  ListButton.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI

struct ListButton: View {
    
    var title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.testTaskLitePurple)
            .overlay(content: {
                HStack(spacing: 12) {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.testTaskBlack)
                .padding(.horizontal, 16)
            })
    }
}
