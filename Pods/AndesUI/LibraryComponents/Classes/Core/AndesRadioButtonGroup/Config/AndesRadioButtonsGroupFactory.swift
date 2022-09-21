//
//  AndesRadioButtonsGroupFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 10/06/21.
//

import Foundation

class AndesRadioButtonsGroupFactory {
    static func provide(_ items: [AndesRadioButtonItem], with align: AndesRadioButtonAlign) -> [AndesRadioButton] {
        items.map { item in
            AndesRadioButton(
                type: item.type,
                align: align,
                status: .unselected,
                title: item.text)
        }
    }
}
