//
//  AndesTextFieldComponentReloadPolicy.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 07/06/2021.
//

import Foundation

@objc public enum AndesTextFieldComponentReloadPolicy: Int, AndesEnumStringConvertible {
    case always
    case onlyOneTime

    public static func keyFor(_ value: AndesTextFieldComponentReloadPolicy) -> String {
        switch value {
        case .always: return "ALWAYS"
        case .onlyOneTime: return "ONLYONETIME"
        }
    }
}
