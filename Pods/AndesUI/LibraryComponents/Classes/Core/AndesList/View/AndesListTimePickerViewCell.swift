//
//  AndesListTimePickerViewCell.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 23/07/21.
//

import Foundation

class AndesListTimePickerViewCell: AndesListCell {
    @IBOutlet private var indicatorview: UIView!

    internal func display(indexPath: IndexPath, customCell: AndesListCell, separatorStyle: AndesSeparatorStyle) {
        setup(customCell: customCell, separatorStyle: separatorStyle)
        indicatorview.layer.cornerRadius = 1

        if customCell.isSelected {
            indicatorview.layer.backgroundColor = AndesStyleSheetManager.styleSheet.accentColor500.cgColor
            titleLbl.textColor = AndesStyleSheetManager.styleSheet.accentColor500
        } else {
            indicatorview.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}
