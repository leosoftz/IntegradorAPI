//
//  
//  AndesTabsView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesTabs
 */
internal protocol AndesTabsView: UIView {
    var delegate: AndesTabsDelegate? { get set }
    func update(withConfig config: AndesTabsViewConfig)
    func updateSelectedTab(at index: Int, animated: Bool)
    func resetTabsElements()
}

protocol AndesTabsDelegate: AnyObject {
    func didSelectTab(at index: Int)
}
