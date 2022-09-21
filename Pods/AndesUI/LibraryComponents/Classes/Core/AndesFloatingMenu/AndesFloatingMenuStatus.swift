//
//  AndesFloatingMenuStatus.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 27/07/2021.
//

import Foundation

typealias OpenPosition = (typeVertical: AndesFloatingOpenTypeVertical, typeHorizontal: AndesFloatingOpenTypeHorizontal)

enum AndesFloatingMenuStatus: Equatable {
    static func == (lhs: AndesFloatingMenuStatus, rhs: AndesFloatingMenuStatus) -> Bool {
        switch (lhs, rhs) {
        case (.closed, .closed):
            return true
        case (.open(let lhsValue), .open(let rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
    case open(openPosition: OpenPosition)
    case closed
}
