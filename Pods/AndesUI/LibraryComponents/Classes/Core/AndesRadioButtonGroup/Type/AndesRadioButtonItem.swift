//
//  AndesRadioButtonItem.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 10/06/21.
//

import Foundation

@objc public class AndesRadioButtonItem: NSObject {
    var text: String
    var type: AndesRadioButtonType

    @objc public init(_ text: String, _ type: AndesRadioButtonType) {
        self.text = text
        self.type = type
    }
}
