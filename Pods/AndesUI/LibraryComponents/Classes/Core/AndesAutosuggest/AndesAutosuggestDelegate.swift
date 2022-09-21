//
//  AndesAutosuggestDelegate.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 26/05/2021.
//

import UIKit

@objc public protocol AndesAutosuggestDelegate {
    // Text Input Delegate
    @objc optional func andesAutosuggestShouldBeginEditing(_ autosuggest: AndesAutosuggest) -> Bool
    @objc optional func andesAutosuggestShouldEndEditing(_ autosuggest: AndesAutosuggest) -> Bool
    @objc optional func andesAutosuggestDidBeginEditing(_ autosuggest: AndesAutosuggest)
    @objc optional func andesAutosuggestDidEndEditing(_ autosuggest: AndesAutosuggest)
    @objc optional func andesAutosuggest(_ autosuggest: AndesAutosuggest, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional func andesAutosuggestDidChangeSelection(_ autosuggest: AndesAutosuggest, selectedRange range: UITextRange?)
    @objc optional func andesAutosuggestDidChange(_ autosuggest: AndesAutosuggest)
    @objc optional func andesAutosuggestDidTapRightAction(_ autosuggest: AndesAutosuggest)
    @objc optional func andesAutosuggestShouldReturn(_ autosuggest: AndesAutosuggest) -> Bool
    @objc optional func andesAutosuggest(_ autosuggest: AndesAutosuggest, didDeleteBackwardAnd wasEmpty: Bool)

    // Suggestions Delegate
    @objc optional func andesAutosuggestSuggestionWasTapped(_ autosuggest: AndesAutosuggest, suggestion: String)
}
