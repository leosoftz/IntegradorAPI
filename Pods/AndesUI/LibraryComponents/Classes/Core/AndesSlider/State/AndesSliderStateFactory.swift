//
//  AndesSliderStateFactory.swift
//  AndesUI
//
//  Created by Victor Chang on 27/02/2021.
//

import Foundation

/**
The responsability of the factory is to provide the right State by providing the AndesSliderState
*/

class AndesSliderStateFactory {
	static func provideState(key: AndesSliderState) -> AndesSliderStateProtocol {
		switch key {
			case .idle:
				return AndesSliderStateIdle()
			case .disable:
				return AndesSliderStateDisable()
		}
	}
}
