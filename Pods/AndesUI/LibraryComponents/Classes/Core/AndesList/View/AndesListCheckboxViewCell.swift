//
//  AndesListCheckboxViewCell.swift
//  AndesUI
//
//  Created by Nicolas Martinez on 26/07/2022.
//

import Foundation

class AndesListCheckboxViewCell: AndesListCell {
    @IBOutlet private var paddingRight: NSLayoutConstraint!
    @IBOutlet private var checkbox: AndesCheckbox!

    internal func display(indexPath: IndexPath, customCell: AndesListCell, separatorStyle: AndesSeparatorStyle) {
        setup(customCell: customCell, separatorStyle: separatorStyle)
        self.setSelected(customCell.isSelected, animated: false)
        self.checkbox.isUserInteractionEnabled = false
        self.paddingRight.constant = customCell.paddingRightSelectionItem ?? 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.checkbox.status = .selected
            self.selectionStyle = .none
        } else {
            self.checkbox.status = .unselected
            self.selectionStyle = .default
        }
        self.accessibilityManager?.viewUpdated()
    }
}
