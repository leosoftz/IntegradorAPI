//
//  AndesTExtInputState+Info.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 5/05/21.
//

import Foundation

extension AndesTextInputState {
    var accessibilityTraits: UIAccessibilityTraits {
        switch self {
        case .error, .warning, .idle:
            return .none
        case .disabled:
            return .notEnabled
        case .readOnly:
            return .staticText
        }
    }

    var accessibilityText: String? {
        switch self {
        case .error:
            return "Error".localized()
        case .warning:
            return "Advertencia".localized()
        default:
            return nil
        }
    }
}
