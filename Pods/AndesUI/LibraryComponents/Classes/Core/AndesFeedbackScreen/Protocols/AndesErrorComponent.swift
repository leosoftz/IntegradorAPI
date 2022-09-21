//
//  AndesErrorComponent.swift
//  AndesUI
//
//  Created by Juan Agustin Aguade Abelenda on 7/3/22.
//

import Foundation

@objc
public protocol AndesErrorComponent {
    /// Get error ux code?
    func getErrorCode() -> String?

    /// Send tracks?
    func onViewCreated()
}
