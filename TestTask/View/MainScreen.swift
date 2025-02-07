//
//  MainScreen.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        let tabItems = TabItem.allItems
        ZStack {
            LinearGradient(colors: [.testTaskWhite, .testTaskLiteGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Group {
                    switch selectedTab {
                    case 0: TranslateScreen()
                    case 1: SettingsScreen()
                    default: TranslateScreen()
                    }
                }
                
                CustomTabBar(selectedTab: $selectedTab, tabItems: tabItems)
                    .frame(width: 216, height: 82)
            }
            .padding(.bottom, 35)
        }
    }
}

struct TabItem {
    let title: String
    let icon: String
    
    static let allItems: [TabItem] = [
        TabItem(title: "Translate", icon: "messages"),
        TabItem(title: "Clicker", icon: "gear"),
    ]
}
