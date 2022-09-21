//
//  AndesSliderStateProtocol.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

internal protocol AndesSliderStateProtocol {
	var isEnabled: Bool { get }
	var sliderColor: UIColor { get }
	var thumbBackgroundColor: UIColor { get }
	var thumbColor: UIColor { get }
}
