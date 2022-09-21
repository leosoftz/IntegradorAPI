//
//  AndesTextFieldView.swift
//  AndesUI
//
//  Created by Martin Damico on 12/03/2020.
//

import Foundation

internal protocol AndesTextFieldView: UIView {
    // expose behaviour to AndesMessage common to all Message Views
    var delegate: AndesTextFieldViewDelegate? { get set }

    var text: String { get set } // input text
    var attributeText: NSAttributedString? { get set }
    var config: AndesTextFieldViewConfig { get }
    var textInputView: UIView { get }
    var customInputView: UIView? { get set }
    var innerTextField: UITextField? { get }
    var customInputAccessoryView: UIView? { get set }
    func update(withConfig config: AndesTextFieldViewConfig)
    func clear()
}
