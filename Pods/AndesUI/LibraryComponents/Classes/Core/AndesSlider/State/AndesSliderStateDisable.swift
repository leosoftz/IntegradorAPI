//
//  AndesSliderStateDisable.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

internal struct AndesSliderStateDisable: AndesSliderStateProtocol {
    var isEnabled = false
    var sliderColor: UIColor = UIColor.Andes.gray100
    var thumbBackgroundColor: UIColor = UIColor.Andes.gray250
    var thumbColor: UIColor = UIColor.Andes.white
}
