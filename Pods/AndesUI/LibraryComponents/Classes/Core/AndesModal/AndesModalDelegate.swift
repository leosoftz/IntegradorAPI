//
//  AndesModalDelegate.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 6/06/22.
//

import Foundation

/// A `AndesModalDelegate` manages user interactions with the modal view's contents.
@objc public protocol AndesModalDelegate {
    /// Tells the delegate that the Modal was closed
    @objc func andesModalDidClose(_ modal: AndesModal)

    /// Tells the delegate that the visible page of the modal was changed, only when the carousel is used, not called when the first page appears, only when the user interacts with the modal.
    /// - Parameters:
    ///   - modal: current modal
    ///   - page: new index of visible page 
    @objc optional func andesModal(_ modal: AndesModal, didPageChangeTo page: Int)

    /// Tell the delegates that the some link was pressed
    /// - Parameters:
    ///   - modal: current modal
    ///   - index: clicked link index
    ///   - label: title or body
    ///   - page: current modal page, 
    @objc optional func andesModal(_ modal: AndesModal, didTouchLink index: Int, at label: AndesLabelType, of page: Int)
}
