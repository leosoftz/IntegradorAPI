//
//  AndesTabsError.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 28/07/21.
//

import Foundation

@objc public enum AndesTabsError: Int, Error, LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .tabNotFound:
            return "The selected tab does not exist"
        }
    }
    case tabNotFound
}
