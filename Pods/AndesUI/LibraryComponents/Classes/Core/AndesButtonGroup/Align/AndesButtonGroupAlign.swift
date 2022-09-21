//
//  AndesButtonGroupAlign.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//

import Foundation

@objc
public enum AndesButtonGroupAlign: Int, AndesEnumStringConvertible {
    case left
    case right
    case center

    public static func keyFor(_ value: AndesButtonGroupAlign) -> String {
        switch value {
        case .left: return "LEFT"
        case .right: return "RIGHT"
        case .center: return "CENTER"
        }
    }
}
