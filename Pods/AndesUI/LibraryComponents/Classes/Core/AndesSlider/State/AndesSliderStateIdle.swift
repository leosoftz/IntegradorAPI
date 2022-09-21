//
//  AndesSliderStateIdle.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

internal struct AndesSliderStateIdle: AndesSliderStateProtocol {
    var isEnabled = true
    var sliderColor: UIColor = UIColor.Andes.gray100
    var thumbBackgroundColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    var thumbColor: UIColor = UIColor.Andes.white
}
