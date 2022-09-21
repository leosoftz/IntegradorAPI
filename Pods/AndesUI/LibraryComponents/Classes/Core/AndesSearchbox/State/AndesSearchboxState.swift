//
//  AndesSearchboxState.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 31/05/2022.
//

import Foundation

@objc public enum AndesSearchboxState: Int, AndesEnumStringConvertible {
    case idle
    case focus

    public static func keyFor(_ value: AndesSearchboxState) -> String {
        switch value {
        case .idle: return "IDLE"
        case .focus: return "FOCUS"
        }
    }
}
