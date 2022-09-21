//
//  AndesListRadioButtonCell.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 01/08/2022.
//

import Foundation

class AndesListRadioButtonViewCell: AndesListCell {
    @IBOutlet private var paddingRight: NSLayoutConstraint!
    @IBOutlet var radioButton: AndesRadioButton!

    internal func display(indexPath: IndexPath, customCell: AndesListCell, separatorStyle: AndesSeparatorStyle) {
        setup(customCell: customCell, separatorStyle: separatorStyle)
        setSelected(customCell.isSelected, animated: true)
        radioButton.isUserInteractionEnabled = false
        paddingRight.constant = customCell.paddingRightSelectionItem ?? 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            radioButton.status = .selected
            self.selectionStyle = .none
        } else {
            radioButton.status = .unselected
            self.selectionStyle = .default
        }
        accessibilityManager?.viewUpdated()
    }
}
