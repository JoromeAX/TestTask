//
//  CustomTabBar.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: Int
    
    let tabItems: [TabItem]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: UIConstants.buttonShadow, y: 4)
            
            HStack(spacing: 42) {
                ForEach(0..<tabItems.count, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            selectedTab = index
                        }
                    }) {
                        VStack {
                            Image(tabItems[index].icon)
                            
                            Text(tabItems[index].title)
                        }
                        .foregroundStyle(.testTaskBlack)
                        .opacity(selectedTab == index ? 1.0 : 0.6)
                        .padding(.top, 10)
                    }
                }
            }
        }
    }
}
