//
//  AndesSearchboxViewDelegate.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 23/05/2022.
//

import Foundation

/// Used to inform events from internal searcbox, views to AndesSearchbox
internal protocol AndesSearchboxViewDelegate: UIView {
    func searchboxView(_ searchboxView: AndesSearchboxView, textDidChange searchText: String)
    func searchboxViewSearchButtonClicked(_ searchboxView: AndesSearchboxView)
    func searchboxTextDidBeginEditing(_ searchbox: AndesSearchboxView)
    func searchboxTextDidEndEditing(_ searchbox: AndesSearchboxView)
}
