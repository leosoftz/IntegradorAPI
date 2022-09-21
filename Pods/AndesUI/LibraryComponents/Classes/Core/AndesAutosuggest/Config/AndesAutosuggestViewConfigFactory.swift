//
//  AndesAutosuggestViewConfigFactory.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 29/06/2021.
//

import UIKit

class AndesAutosuggestViewConfigFactory: NSObject {
    static func provideInternalConfig(autosuggest: AndesAutosuggest) -> AndesAutosuggestViewConfig {
        return AndesAutosuggestViewConfig(
            state: autosuggest.state,
            label: autosuggest.label,
            helper: autosuggest.helper,
            counter: autosuggest.counter,
            placeholder: autosuggest.placeholder,
            leftContent: autosuggest.leftContent,
            rightContent: autosuggest.rightContent,
            inputTraits: autosuggest.inputTraits)
    }
}
