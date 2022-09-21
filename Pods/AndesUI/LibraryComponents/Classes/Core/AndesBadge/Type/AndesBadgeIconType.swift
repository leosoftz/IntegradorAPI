//
//  AndesBadgeType.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 19/08/21.
//

import Foundation

@objc public enum AndesBadgeIconType: Int, AndesEnumStringConvertible {
    case accent
    case green
    case orange
    case red
    case gray

    public static func keyFor(_ value: AndesBadgeIconType) -> String {
        switch value {
        case .accent: return "ACCENT"
        case .green: return "GREEN"
        case .orange: return "ORANGE"
        case .red: return "RED"
        case .gray: return "GRAY"
        }
    }

    public init?(from type: AndesBadgeType) {
        switch type {
        case .highlight: self.init(from: "accent")
        case .success: self.init(from: "green")
        case .warning: self.init(from: "orange")
        case .error: self.init(from: "red")
        case .neutral: self.init(from: "orange")
        case .disable: self.init(from: "gray")
        }
    }

    func andesBadgeType() -> AndesBadgeType {
        switch self {
        case .accent: return .highlight
        case .green: return .success
        case .orange: return .warning
        case .red: return .error
        case .gray: return .disable
        }
    }
}
