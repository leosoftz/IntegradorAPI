//
//  AndesCarouselView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 08/02/2021.
//

import Foundation

internal protocol AndesCarouselView: UIView {
    func update(withConfig config: AndesCarouselViewConfig)
}
