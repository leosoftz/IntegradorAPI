//
//  
//  AndesSwitchView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesSwitch
 */
internal protocol AndesSwitchView: UIView {
    func update(withConfig config: AndesSwitchViewConfig)
}
