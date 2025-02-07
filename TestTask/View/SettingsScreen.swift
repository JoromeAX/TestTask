//
//  SettingsScreen.swift
//  TestTask
//
//  Created by Roman Khancha on 07.02.2025.
//

import SwiftUI

struct SettingsScreen: View {

    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                Text("Settings")
                    .font(.system(size: 32))
                    .bold()
                
                ForEach(SettingsButtonType.allCases, id: \.self) { button in
                    VStack(spacing: 14) {
                        ListButton(title: button.rawValue)
                            .frame(height: 50)
                            .onTapGesture {
                                
                            }
                            .padding(.horizontal, 16)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.testTaskBlack)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.vertical, 12)
        }
    }
}

enum SettingsButtonType: String, CaseIterable {
    case rateUs = "Rate Us"
    case share = "Share App"
    case contact = "Contact Us"
    case restore = "Restore Purchases"
    case privacy = "Privacy Policy"
    case terms = "Terms of Use"
}
