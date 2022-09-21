//
//  
//  AndesRadioButtonGroupView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesRadioButtonGroup
 */
internal protocol AndesRadioButtonGroupView: UIView {
    func update(withConfig config: AndesRadioButtonGroupViewConfig)
}
