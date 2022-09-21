//
//  
//  AndesButtonGroupView.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesButtonGroup
 */
internal protocol AndesButtonGroupView: UIView {
    func update(withConfig config: AndesButtonGroupViewConfig)
}
