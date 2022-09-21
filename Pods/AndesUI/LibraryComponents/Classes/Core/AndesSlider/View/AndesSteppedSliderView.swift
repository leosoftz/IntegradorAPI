//
//  AndesSteppedSliderView.swift
//  AndesUI
//
//  Created by Victor Chang on 29/04/2021.
//

import Foundation

class AndesSliderSteppedView: AndesSliderAbstractView {
    private var steps: Int = 0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    private var state: AndesSliderState = .idle {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    private var stepperViewCount: Int = 0
    private var stepDistance: CGFloat = 0.0

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesSliderAbstractView", owner: self, options: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawStepSeparators(with: steps, slider: sliderView)
        removeSteppersWhenDisabled()
        accessibilitySlider?.updateLayout(with: calculateStepValue(for: steps))
    }

    override func updateView() {
        super.updateView()
        self.steps = self.config.numberOfSteps ?? 0
        self.state = self.config.state
    }

    fileprivate func drawStepSeparators(with steps: Int, slider: UISlider) {
        let sliderTrack: CGRect = sliderView.trackRect(forBounds: sliderView.bounds)
        let stepDistance = sliderTrack.width / CGFloat(steps - 1)

        if stepperViewCount == steps - 2 && stepDistance == self.stepDistance { return }
        stepperViewCount = 0
        self.stepDistance = stepDistance

        sliderView.subviews.forEach { view in
            if let stepperView = view as? AndesStepperView {
                stepperView.removeFromSuperview()
            }
        }

        if steps <= 12 && steps >= 3 {
            let stepValue = steps - 2
            for index in 0..<stepValue {
                let tick = AndesStepperView(frame: CGRect(x: stepDistance * CGFloat((index + 1)), y: sliderTrack.origin.y, width: sliderTrack.height, height: sliderTrack.height))
                tick.layer.cornerRadius = sliderTrack.height / 2
                tick.backgroundColor = UIColor.Andes.gray070.withAlphaComponent(0.25)
                stepperViewCount += 1
                sliderView.insertSubview(tick, at: 0)
            }
        }
    }

    fileprivate func removeSteppersWhenDisabled() {
        if state == .disable {
            sliderView.subviews.forEach { view in
                if let stepperView = view as? AndesStepperView {
                    stepperView.removeFromSuperview()
                }
            }
            stepperViewCount = 0
        } else if state == .idle {
            drawStepSeparators(with: steps, slider: sliderView)
        }
    }

    override func sliderAction(_ sender: UISlider) {
        setupSteppedSlider(with: config.numberOfSteps ?? 3, sender: sender)
        super.sliderAction(sender)
        let value = sender.value
        delegate?.onValueChanged(value: Double(value), sender: sender)
    }

    fileprivate func setupSteppedSlider(with steps: Int, sender: UISlider) {
        let stepValue = calculateStepValue(for: steps)
        let roundValue = round(sender.value / stepValue) * stepValue
        sender.value = roundValue
    }

    private func calculateStepValue(for steps: Int) -> Float {
        Float(sliderView.maximumValue - sliderView.minimumValue) / Float(steps - 1)
    }

    override func setupAccessibility() {
        let accessibilitySlider = UIAccessibilitySlider(slider: self.sliderView, delegate: self)
        self.accessibilitySlider = accessibilitySlider
    }
}

class AndesStepperView: UIView {
// this class was created to eventually remove stepps from superview when needed
}
