//
//  AndesSearchboxDelegate.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 22/05/2022.
//

import Foundation

@objc public protocol AndesSearchboxDelegate {
    func andesSearchbox(_ searchbox: AndesSearchbox, textDidChange searchText: String)
    // Consultar por este requerimiento
    @objc optional func textDidEndEditing(searchBox: AndesSearchbox, text: String)
    func andesSearchboxSearchButtonClicked(_ searchBox: AndesSearchbox)
}
