//
//  AndesSearchboxView.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 21/05/2022.
//

import Foundation

// Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesSearchbox
internal protocol AndesSearchboxView: UIView {
    var delegate: AndesSearchboxViewDelegate? { get set }
    var searchText: String? { get set }
    func update(withConfig config: AndesSearchboxViewConfig)
}
