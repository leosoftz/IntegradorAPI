//
//  
//  AndesMoneyAmountCombo.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 6/09/21.
//
//

import Foundation

@objc public class AndesMoneyAmountCombo: UIView, AndesAccessibleView {
    internal var contentView: AndesMoneyAmountComboView!

    @objc public var price: Double = 0.0 {
        didSet {
            updateContentView()
        }
    }

    @objc public var currency: AndesMoneyAmountCurrency = .USD {
        didSet {
            validateCryptoCurrency()
            updateContentView()
        }
    }

    @objc public var size: AndesMoneyAmountComboSize = .size24 {
        didSet {
            updateContentView()
        }
    }

    @objc public var discount: Int = 0 {
        didSet {
            updateContentView()
        }
    }

    public var previousPrice: Double? {
        didSet {
            updateContentView()
        }
    }

    public var previousPriceObjc: NSNumber? {
        didSet {
            if let previousPriceUnwraped = previousPriceObjc as? Double {
                previousPrice = previousPriceUnwraped
            }
        }
    }

    /// This country variable is used if you want to give a specific format of a site
    @objc public var country: AndesCountry = .DEFAULT {
        didSet {
            updateContentView()
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init(price: Double, size: AndesMoneyAmountComboSize, previousPrice: Double?, discount: Int = 0, currency: AndesMoneyAmountCurrency = .USD) {
        super.init(frame: .zero)
        self.price = price
        self.size = size
        self.previousPrice = previousPrice
        self.discount = discount
        self.currency = currency
        setup()
    }

    @objc public init(price: Double, size: AndesMoneyAmountComboSize, previousPriceObjc: NSNumber?, discount: Int = 0, currency: AndesMoneyAmountCurrency = .USD) {
        super.init(frame: .zero)
        self.price = price
        self.size = size
        self.previousPriceObjc = previousPriceObjc
        self.discount = discount
        self.currency = currency
        setup()
    }

    private func setup() {
        validateCryptoCurrency()

        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
        accessibilityManager = AndesMoneyAmountComboAccessibilityManager(view: self)
    }

    private func drawContentView(with newView: AndesMoneyAmountComboView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesMoneyAmountComboViewConfigFactory.provideInternalConfig(size: size, price: price, discount: discount, previousPricePrice: previousPrice, currency: currency)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }

    func validateCryptoCurrency() {
        guard let currencyInfo = AndesMoneyAmount.moneyAmountCurrencyInfo(for: currency, and: country) else { return }

        if currencyInfo.isCrypto {
            FatalErrorUtil.fatalErrorClosure("This currency is not valid for AndesMoneyAmountCombo", #file, #line)
        }
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesMoneyAmountComboView {
        let config = AndesMoneyAmountComboViewConfigFactory.provideInternalConfig(size: size, price: price, discount: discount, previousPricePrice: previousPrice, currency: currency)
        return AndesMoneyAmountComboViewDefault(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesMoneyAmountCombo {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'size' instead.")
    @IBInspectable var ibSize: String {
        set(val) {
            self.size = AndesMoneyAmountComboSize.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.size.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'price' instead.")
    @IBInspectable var ibPrice: Double {
        set(val) {
            self.price = val
        }
        get {
            return self.price
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'currency' instead.")
    @IBInspectable var ibCurrency: String {
        set(val) {
            self.currency = AndesMoneyAmountCurrency.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.currency.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'discount' instead.")
    @IBInspectable var ibDiscount: Int {
        set(val) {
            self.discount = val
        }
        get {
            return self.discount
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'price' instead.")
    @IBInspectable var ibPreviousPrice: Double {
        set(val) {
            self.previousPrice = val
        }
        get {
            return self.previousPrice ?? 0.0
        }
    }
}
