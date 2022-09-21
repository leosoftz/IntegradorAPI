//
//  AndesInputStepperAbstractView.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import UIKit

internal class AndesInputStepperAbstractView: UIView, AndesInputStepperView {
    @IBOutlet private(set) var previousButton: AndesButtonInputStepperView!
    @IBOutlet private(set) var nextButton: AndesButtonInputStepperView!
    @IBOutlet private var label: UILabel!
    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private var container: UIView!
    @IBOutlet private var disabledView: UIView!
    @IBOutlet private(set) var progress: AndesProgressIndicatorIndeterminate!

    @IBOutlet private var previousButtonWidth: NSLayoutConstraint!
    @IBOutlet private var previousButtonHeight: NSLayoutConstraint!
    @IBOutlet private var previousButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet private var previousButtonLateralConstraint: NSLayoutConstraint!
    @IBOutlet private var nextButtonWidth: NSLayoutConstraint!
    @IBOutlet private var nextButtonHeight: NSLayoutConstraint!
    @IBOutlet private var nextButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet private var nextButtonLateralConstraint: NSLayoutConstraint!

    weak var delegate: AndesInputStepperViewDelegate?
    weak var dataSource: AndesInputStepperViewTextDataSource?

    var isLoading = false {
        didSet {
            if oldValue != self.isLoading {
                self.updateLoadingState()
            }
            self.accessibilityManager?.viewUpdated()
        }
    }

    var isEnabled = true {
        didSet {
            self.setupVisualState()
            self.accessibilityManager?.viewUpdated()
        }
    }

    var config: AndesInputStepperViewConfig = DefaultsInputStepper.createConfig() {
        didSet {
            self.updateView()
            self.accessibilityManager?.viewUpdated()
        }
    }

    private var state: AndesInputStepperState = .inRange
    var accessibilityManager: AndesAccessibilityManager?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    internal init(config: AndesInputStepperViewConfig,
                  delegate: AndesInputStepperViewDelegate? = nil,
                  dataSource: AndesInputStepperViewTextDataSource? = nil) {
        super.init(frame: .zero)
        self.config = config
        self.delegate = delegate
        self.dataSource = dataSource
        self.setup()
    }

    private func setup() {
        self.loadNib()
        self.setupPreviousButton()
        self.setupNextButton()
        self.setupContainer()
        self.setupProgress()
        self.updateView()
        self.setupAccessibility()
    }

    internal func loadNib() {
        fatalError("This should be override by a subclass")
    }

    private func setupPreviousButton() {
        self.previousButtonTopConstraint.constant = self.config.size.buttonTopConstraint
        self.previousButtonLateralConstraint.constant = self.config.size.buttonLateralConstraint
        self.previousButtonWidth.constant = self.config.size.buttonWidth
        self.previousButtonHeight.constant = self.config.size.buttonHeight
        self.previousButton.setupContentView(config: self.config)
    }

    private func setupNextButton() {
        self.nextButtonTopConstraint.constant = self.config.size.buttonTopConstraint
        self.nextButtonLateralConstraint.constant = self.config.size.buttonLateralConstraint
        self.nextButtonWidth.constant = self.config.size.buttonWidth
        self.nextButtonHeight.constant = self.config.size.buttonHeight
        self.nextButton.setupContentView(config: self.config)
    }

    private func setupContainer () {
        self.container.setRectangleShapeWithBorder(borderColor: DefaultsInputStepper.grayColor, borderWidth: self.config.size.borderWidth, cornerRadius: self.config.size.cornerRadius, roundedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }

    private func setupProgress() {
        self.progress.size = self.config.size.progress
        self.progress.tint = DefaultsInputStepper.tint
    }

    private func setupAccessibility() {
        self.accessibilityManager = AndesInputStepperAccessibilityManager(view: self)
    }

    private func updateView() {
        self.updateState()
        self.setupVisualState()
        self.setupLabel()
    }

    private func updateState() {
        if self.isMinValue(position: self.config.value) {
            self.state = .minSelected
        } else if self.isMaxValue(position: self.config.value) {
            self.state = .maxSelected
        } else {
            self.state = .inRange
        }
    }

    private func isMaxValue(position: Int) -> Bool {
        return position == self.config.maxValue
    }

    private func isMinValue(position: Int) -> Bool {
        return position == self.config.minValue
    }

    private func setupVisualState() {
        if !self.isEnabled {
            self.setupIcons(color: DefaultsInputStepper.grayColor)
            self.setupButtonsInputStepperState(isEnabled: false)
            self.setupDisabledView(isHidden: false)
        } else if self.state == .maxSelected {
            self.setupIconLeft(color: DefaultsInputStepper.tint)
            self.setupIconRight(color: DefaultsInputStepper.grayColor)
            self.setupPreviousButtonState(isEnabled: true)
            self.setupNextButtonState(isEnabled: false)
            self.setupDisabledView(isHidden: true)
        } else if self.state == .minSelected {
            self.setupIconRight(color: DefaultsInputStepper.tint)
            self.setupIconLeft(color: DefaultsInputStepper.grayColor)
            self.setupPreviousButtonState(isEnabled: false)
            self.setupNextButtonState(isEnabled: true)
            self.setupDisabledView(isHidden: true)
        } else {
            self.setupIcons(color: DefaultsInputStepper.tint)
            self.setupButtonsInputStepperState(isEnabled: true)
            self.setupDisabledView(isHidden: true)
        }
    }

    private func setupIcons(color: UIColor) {
        self.setupIconLeft(color: color)
        self.setupIconRight(color: color)
    }

    private func setupIconLeft(color: UIColor) {
        self.previousButton.drawMinus(config: self.config, color: color)
    }

    private func setupIconRight(color: UIColor) {
        self.nextButton.drawAdd(config: self.config, color: color)
    }

    private func setupButtonsInputStepperState(isEnabled: Bool) {
        self.setupPreviousButtonState(isEnabled: isEnabled)
        self.setupNextButtonState(isEnabled: isEnabled)
    }

    private func setupPreviousButtonState(isEnabled: Bool) {
        self.previousButton.isEnabled = isEnabled
    }

    private func setupNextButtonState(isEnabled: Bool) {
        self.nextButton.isEnabled = isEnabled
    }

    private func setupDisabledView(isHidden: Bool) {
        self.disabledView.isHidden = isHidden
        if isHidden {
            self.setupContainer()
        } else {
            self.removeContainerBorder()
            self.removeSublayers(view: self.disabledView)
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.disabledView.setRectangleShapeWithDashedLine(
                    tint: DefaultsInputStepper.disabledColor,
                    borderColor: DefaultsInputStepper.grayColor,
                    borderWidth: strongSelf.config.size.borderWidth,
                    cornerRadius: strongSelf.config.size.cornerRadius)
            }
        }
    }

    private func removeContainerBorder() {
        self.container.layer.borderColor = nil
        self.container.layer.borderWidth = 0.0
    }

    private func removeSublayers(view: UIView) {
        view.layer.sublayers?.removeAll()
    }

    private func setupLabel() {
        self.label.textColor = DefaultsInputStepper.textColor
        self.label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: self.config.size.font)
        if let text = self.dataSource?.andesInputStepperView(self, textFor: self.config.value) {
            self.label.attributedText = text
        }
    }

    @IBAction private func didTouchPlusButton() {
        nextStep()
    }

    func nextStep() {
        guard isEnabled, !isLoading else { return }
        let nextValue = getNextValue()
        if self.isNecessaryUpdateValue(value: nextValue) {
            self.config.value = nextValue
            self.notifyChanges(sender: .next)
        }
    }

    private func getNextValue() -> Int {
        let nextValue = self.config.value + self.config.step
        if nextValue > config.maxValue {
            return config.maxValue
        }
        return nextValue
    }

    @IBAction private func didTouchMinusButton() {
        previousStep()
    }

    func previousStep() {
        guard isEnabled, !isLoading  else { return }
        let previousValue = getPreviousValue()
        if self.isNecessaryUpdateValue(value: previousValue) {
            self.config.value = previousValue
            self.notifyChanges(sender: .previous)
        }
    }

    private func getPreviousValue() -> Int {
        let previousValue = self.config.value - self.config.step
        if previousValue < config.minValue {
            return config.minValue
        }
        return previousValue
    }

    private func isNecessaryUpdateValue(value: Int) -> Bool {
        return self.dataSource?.andesInputStepperView(self, textFor: value) != nil
    }

    private func notifyChanges(sender: AndesInputStepperSender) {
        self.delegate?.andesInputStepperView(self, didSelect: self.config.value, state: self.state, sender: sender)
    }

    internal func updateInputStepperConstraints() {
        self.pinToSuperview()
        self.container.pinToSuperview()
    }

    override func accessibilityIncrement() {
        (accessibilityManager as? AndesInputStepperAccessibilityManager)?.accessibilityIncrement()
    }

    override func accessibilityDecrement() {
        (accessibilityManager as? AndesInputStepperAccessibilityManager)?.accessibilityDecrement()
    }
}

// MARK: Setup loading
extension AndesInputStepperAbstractView {
    private func updateLoadingState() {
        if !self.isEnabled {
            return
        }

        if self.isLoading {
            self.showStepper()
        } else {
            self.hideStepper()
        }
    }

    private func showStepper() {
        self.progress.startAnimation()
        self.appearStepperAnimation()
    }

    private func hideStepper() {
        self.dissapearStepperAnimation {
            self.updateView()
        }
    }

    private func appearStepperAnimation() {
        self.clipsToBounds = true
        self.progress.alpha = 0
        self.contentView.alpha = 1
        self.progress.transform = CGAffineTransform(translationX: 0, y: DefaultsInputStepper.stepperTransitionPosition)
        self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)

        UIView.animate(
            withDuration: DefaultsInputStepper.stepperTransitionDuration,
            delay: 0,
            options: [.curveEaseIn],
            animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -DefaultsInputStepper.stepperTransitionPosition)
                self.progress.transform = CGAffineTransform(translationX: 0, y: 0)
                self.progress.alpha = 1
                self.contentView.alpha = 0
            }
        )
    }

    private func dissapearStepperAnimation(completion: (() -> Void)? = nil) {
        self.clipsToBounds = true
        self.progress.alpha = 1
        self.contentView.alpha = 0
        self.contentView.transform = CGAffineTransform(translationX: 0, y: DefaultsInputStepper.stepperTransitionPosition)
        self.progress.transform = CGAffineTransform(translationX: 0, y: 0)

        UIView.animate(
            withDuration: DefaultsInputStepper.stepperTransitionDuration,
            delay: 0,
            options: [.curveEaseIn],
            animations: {
                self.progress.transform = CGAffineTransform(translationX: 0, y: -DefaultsInputStepper.stepperTransitionPosition)
                self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.progress.alpha = 0
                self.contentView.alpha = 1
            }
        ) { _ in
            completion?()
        }
    }
}
