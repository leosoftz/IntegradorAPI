//
//  AndesAmountFieldHelperStateEnum.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 11/04/2022.
//

import Foundation

enum AndesAmountFieldHelperStateEnum {
    case normal(text: String)
    case error(text: String)

    func textA11y() -> String {
        switch self {
        case .normal(let text):
            return text
        case .error(let text):
            return "Error".localized() + "," + text
        }
    }
}
