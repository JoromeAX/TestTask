//
//  PhysicsCategory.swift
//  TestTask
//
//  Created by Roman Khancha on 09.01.2025.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0x1 << 0
    static let circle: UInt32 = 0x1 << 1
    static let obstacle: UInt32 = 0x1 << 2
}
