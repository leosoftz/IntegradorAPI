//
//  AndesAutosuggestViewConfig.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 27/06/2021.
//

import UIKit

/**
The AndesAutosuggestViewConfig contains the differents customizable attributes of the view
*/
internal struct AndesAutosuggestViewConfig {
    var state: AndesTextInputState = .idle
    var label: String?
    var helper: String?
    var counter: UInt16 = 0
    var placeholder: String?
    var leftContent: AndesTextFieldLeftComponent?
    var rightContent: AndesTextFieldRightComponent?
    var inputTraits: UITextInputTraits?

    // Floating Menu config
    var menuPadding: CGFloat = 8
    var menuAnimationDuration: CGFloat = 0.2
    var menuIntrinsicSize: CGFloat = 100
    var menuCornerRadius: CGFloat = 6
    var menuTopPadding: CGFloat = 44
    var menuBottomPadding: CGFloat = 60

    init(state: AndesTextInputState, label: String?, helper: String?, counter: UInt16, placeholder: String?, leftContent: AndesTextFieldLeftComponent?, rightContent: AndesTextFieldRightComponent?, inputTraits: UITextInputTraits?) {
        self.state = state
        self.label = label
        self.helper = helper
        self.counter = counter
        self.placeholder = placeholder
        self.leftContent = leftContent
        self.rightContent = rightContent
        self.inputTraits = inputTraits
    }

    init() {
    }
}
