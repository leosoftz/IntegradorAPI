//
//  AndesAutosuggestDatasource.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 26/05/2021.
//

import UIKit

@objc public protocol AndesAutosuggestDatasource {
    @objc optional func andesAutosuggestSuperView(_ autosuggest: AndesAutosuggest) -> UIView
    @objc func andesAutosuggestSuggestions(_ autosuggest: AndesAutosuggest) -> [String]
}
