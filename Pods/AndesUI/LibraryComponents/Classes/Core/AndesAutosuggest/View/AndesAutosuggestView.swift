//
//  AndesAutosuggestView.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 25/05/2021.
//

import Foundation

internal protocol AndesAutosuggestViewDatasource: AnyObject {
    func suggestions() -> [String]
    func superView() -> UIView
}

internal protocol AndesAutosuggestViewDelegate: AnyObject {
    // Text input delegate
    func didBeginEditing()
    func didEndEditing(text: String)
    func shouldBeginEditing() -> Bool
    func shouldEndEditing() -> Bool
    func textField(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func didChangeSelection(selectedRange range: UITextRange?)
    func didChange()
    func didTapRightAction()
    func shouldReturn() -> Bool
    func didDeleteBackward(_ andWasEmpty: Bool)

    // Suggestions delegate
    func suggestionWasTapped(suggestion: String)

    // Accesibility delegate
    func onAccessibilityPerformEscapeActivated()
}

internal protocol AndesAutosuggestView: UIView {
//    Attributes
    var delegate: AndesAutosuggestViewDelegate! { get set }
    var datasource: AndesAutosuggestViewDatasource! { get set }
    var text: String { get set } // input text

//    Methods
    func update(with config: AndesAutosuggestViewConfig)
    func reloadData()
    func showSuggestions(availableFrame: CGRect)
    func hideSuggestions()
}
