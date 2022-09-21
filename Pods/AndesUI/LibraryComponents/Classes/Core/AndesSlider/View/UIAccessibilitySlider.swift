//
//  UIAccessibilitySlider.swift
//  AndesUI
//
//  Created by Laura Milena Sarmiento Almanza on 15/08/22.
//

import Foundation
import UIKit

class UIAccessibilitySlider: UIAccessibilityElement {
    private weak var delegate: SliderAccesibilityDelegate?
    private weak var slider: UISlider?
    private var value: Float? = 0.0

    init(slider: UISlider, delegate: SliderAccesibilityDelegate) {
        self.slider = slider
        self.delegate = delegate
        super.init(accessibilityContainer: slider)
        isAccessibilityElement = true
        slider.accessibilityElements = [self]
        slider.isAccessibilityElement = false
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get { .adjustable }
        set {}
    }

    override func accessibilityIncrement() {
        guard let slider = slider, let value = value else { return }
        slider.value += value
        delegate?.sliderAction(slider)
        accessibilityValue = delegate?.sliderAccessibilityValue
    }

    override func accessibilityDecrement() {
        guard let slider = slider, let value = value else { return }
        slider.value -= value
        delegate?.sliderAction(slider)
        accessibilityValue = delegate?.sliderAccessibilityValue
    }

    func updateLayout(with value: Float) {
        accessibilityFrameInContainerSpace = slider?.bounds ?? .zero
        self.value = value
    }
}
