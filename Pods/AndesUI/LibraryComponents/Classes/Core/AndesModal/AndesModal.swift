//
//  AndesModal.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 13/05/22.
//

import UIKit
import PureLayout

/// Public interface, exposes the methods for andes Modal
@objc
public protocol AndesModal {
    var currentPage: Int { get }
    /// Manages user interactions with the modal view's contents.
    var delegate: AndesModalDelegate? { get set }
    /// Show the modal in the view
    /// - Parameter parentVC: Controller to present modal
    func show(in parentVC: UIViewController)

    /// Close the modal programmatically
    func close()
}

public extension AndesModal {
    /// Stores this modal instance in the specified variable.
    @discardableResult
    func store(in reference: inout AndesModal?) -> Self {
        reference = self
        return self
    }
}
