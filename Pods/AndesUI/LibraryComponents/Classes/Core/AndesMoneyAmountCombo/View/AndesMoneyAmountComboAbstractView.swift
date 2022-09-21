//
//  
//  AndesMoneyAmountComboAbstractView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import UIKit

class AndesMoneyAmountComboAbstractView: UIView, AndesMoneyAmountComboView {
    @IBOutlet var componentView: UIView!
    @IBOutlet var moneyAmountPrice: AndesMoneyAmount!
    @IBOutlet var moneyAmountPrevious: AndesMoneyAmount!
    @IBOutlet var moneyAmountDiscount: AndesMoneyAmountDiscount!
    @IBOutlet var constraintForPrevious: NSLayoutConstraint!
    @IBOutlet var constraintForDiscount: NSLayoutConstraint!

    var config: AndesMoneyAmountComboViewConfig

    init(withConfig config: AndesMoneyAmountComboViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMoneyAmountComboViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesMoneyAmountComboViewConfig) {
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

    func updateView() {
        configureMoneyAmount()
        configureDiscount()
        configurePrevious()
    }

    private func configureMoneyAmount() {
        moneyAmountPrice.amount = config.moneyAmount.amount
        moneyAmountPrice.currency = config.moneyAmount.currency
        moneyAmountPrice.size = config.moneyAmount.size
        moneyAmountPrice.country = config.moneyAmount.country
    }

    private func configureDiscount() {
        if let discountMoneyAmount = config.discount {
            moneyAmountDiscount.isHidden = false
            constraintForDiscount.priority = .defaultLow
            moneyAmountDiscount.discountValue = discountMoneyAmount.discountValue
            moneyAmountDiscount.size = discountMoneyAmount.size
        } else {
            moneyAmountDiscount.isHidden = true
            constraintForDiscount.priority = .required
        }
    }

    private func configurePrevious() {
        if let previousMoneyAmount = config.previous, previousMoneyAmount.type == .previous {
            constraintForPrevious.priority = .defaultLow
            moneyAmountPrevious.isHidden = false
            moneyAmountPrevious.amount = previousMoneyAmount.amount
            moneyAmountPrevious.currency = previousMoneyAmount.currency
            moneyAmountPrevious.size = previousMoneyAmount.size
            moneyAmountPrevious.type = previousMoneyAmount.type
        } else {
            moneyAmountPrevious.isHidden = true
            constraintForPrevious.priority = .required
        }
    }
}
