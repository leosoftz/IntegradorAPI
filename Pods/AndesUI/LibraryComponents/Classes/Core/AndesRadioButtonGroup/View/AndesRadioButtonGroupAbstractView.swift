//
//  
//  AndesRadioButtonGroupAbstractView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import UIKit

class AndesRadioButtonGroupAbstractView: UIView, AndesRadioButtonGroupView {
    @IBOutlet var componentView: UIView!
    @IBOutlet var stackView: UIStackView!

    var config: AndesRadioButtonGroupViewConfig
    private let unselectedItem = -1
    weak var componentDelegate: AndesRadioButtonGroupDelegate?

    init(withConfig config: AndesRadioButtonGroupViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesRadioButtonGroupViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesRadioButtonGroupViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        verifyBounds()
        resetGroupView()
        addRadioButtonItems()
    }

    private func verifyBounds() {
        guard config.selected < config.radioButtons.count,
              config.selected >= unselectedItem else {
            fatalError("Selected item inside a radio button should be between \(unselectedItem) and \(config.radioButtons.count - 1)")
        }
    }

    private func resetGroupView() {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        stackView.axis = config.distribution.align
        stackView.spacing = config.distribution.spacing
    }

    private func addRadioButtonItems() {
        for (index, andesRadioButton) in config.radioButtons.enumerated() {
            setupRadioButton(andesRadioButton, index)
            stackView.addArrangedSubview(andesRadioButton)
        }
    }

    private func setupRadioButton(_ andesRadioButton: AndesRadioButton, _ index: Int) {
        andesRadioButton.titleNumberOfLines = 1
        andesRadioButton.setRadioButtonTapped(callback: { [weak self] _ in
            self?.componentDelegate?.didSelectIndex(index)
        })
        resetErrorIfNeeded(andesRadioButton)
        andesRadioButton.status = config.selected == index ? .selected : .unselected
    }

    private func resetErrorIfNeeded(_ andesRadioButton: AndesRadioButton) {
        if andesRadioButton.type == .error, config.selected != unselectedItem {
            andesRadioButton.type = .idle
        }
    }
}
