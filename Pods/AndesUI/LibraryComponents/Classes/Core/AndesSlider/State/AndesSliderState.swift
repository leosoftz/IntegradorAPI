//
//  AndesSliderState.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

/**
AndesSliderState represent the state of the componen: {idle, disable}
*/

@objc public enum AndesSliderState: Int, AndesEnumStringConvertible {
    case idle
    case disable

    public static func keyFor(_ value: AndesSliderState) -> String {
        switch value {
            case .idle: return "IDLE"
            case .disable: return "DISABLE"
        }
    }
}
