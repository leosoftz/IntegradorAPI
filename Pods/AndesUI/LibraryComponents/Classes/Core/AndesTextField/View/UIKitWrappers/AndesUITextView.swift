//
//  AndesUITextView.swift
//  Adjust
//
//  Created by Nicolas Rostan Talasimov on 4/17/20.
//

import UIKit
class AndesUITextView: UITextView, AndesTextInputCustomBorderView {
    var onNeedsBorderUpdate: ((UIView) -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        self.onNeedsBorderUpdate?(self)
    }

    func setInputTraits(_ traits: UITextInputTraits) {
       if let autocapitalizationType = traits.autocapitalizationType {
           self.autocapitalizationType = autocapitalizationType
       }
       if let autocorrectionType = traits.autocorrectionType {
           self.autocorrectionType = autocorrectionType
       }
       if let spellCheckingType = traits.spellCheckingType {
           self.spellCheckingType = spellCheckingType
       }
       if let enablesReturnKeyAutomatically = traits.enablesReturnKeyAutomatically {
           self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
       }
       if let isSecureTextEntry = traits.isSecureTextEntry {
           self.isSecureTextEntry = isSecureTextEntry
       }
       if let keyboardAppearance = traits.keyboardAppearance {
           self.keyboardAppearance = keyboardAppearance
       }
       if let keyboardType = traits.keyboardType {
           self.keyboardType = keyboardType
       }
       if let returnKeyType = traits.returnKeyType {
           self.returnKeyType = returnKeyType
       }
       if let textContentType = traits.textContentType {
           self.textContentType = textContentType
       }
        if let passwordRules = traits.passwordRules {
            self.passwordRules = passwordRules
        }
        if let smartQuotesType = traits.smartQuotesType {
            self.smartQuotesType = smartQuotesType
        }
        if let smartDashesType = traits.smartDashesType {
            self.smartDashesType = smartDashesType
        }
        if let smartInsertDeleteType = traits.smartInsertDeleteType {
           self.smartInsertDeleteType = smartInsertDeleteType
        }
    }
}

protocol AndesTextInputCustomBorderView {
    var onNeedsBorderUpdate: ((UIView) -> Void)? { get set }
}
