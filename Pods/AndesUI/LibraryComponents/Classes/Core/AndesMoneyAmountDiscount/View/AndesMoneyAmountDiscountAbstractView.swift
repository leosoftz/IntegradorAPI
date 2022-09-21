//
//  
//  AndesDiscountAbstractView.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import UIKit

class AndesMoneyAmountDiscountAbstractView: UIView, AndesMoneyAmountDiscountView {
    private(set) var discountLabel: UILabel?

    private var image: UIImageView?
    private var discountLabelLeadingConstraint: NSLayoutConstraint?
    private var config: AndesMoneyAmountDiscountViewConfig

    init(withConfig config: AndesMoneyAmountDiscountViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMoneyAmountDiscountViewConfig()
        super.init(coder: coder)
        setup()
    }

    func update(withConfig config: AndesMoneyAmountDiscountViewConfig) {
        self.config = config
        updateView()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        createLabel()
        updateView()
    }

    private func createLabel() {
        discountLabel = UILabel()
        discountLabel?.translatesAutoresizingMaskIntoConstraints = false

        if let label = self.discountLabel {
            addSubview(label)
        }

        discountLabelLeadingConstraint = discountLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        discountLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        discountLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        discountLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        discountLabelLeadingConstraint?.isActive = true
    }

    func isHasImage() -> Bool {
        return image != nil
    }

    private func createImage() {
        guard let configSizeString = config.size else { return }

        discountLabelLeadingConstraint?.constant = (getIconSizeFor(configSizeString) ?? 0.0) + 10

        image = UIImageView(image: config.icon)

        if let image = self.image {
            addSubview(image)
            image.image = image.image?.withRenderingMode(.alwaysTemplate)
            image.translatesAutoresizingMaskIntoConstraints = false
            image.tintColor = AndesStyleSheetManager.styleSheet.textColorPositive

            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            image.widthAnchor.constraint(equalToConstant: getIconSizeFor(configSizeString) ?? 0.0).isActive = true
            image.heightAnchor.constraint(equalToConstant: getIconSizeFor(configSizeString) ?? 0.0).isActive = true
        }
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        guard let configSizeString = config.size,
              let size = getSizeFor(configSizeString, isForSuperScript: false) else { return }
        discountLabel?.font = discountLabel?.font.withSize(size)
        discountLabel?.text = "\(config.discountValue ?? 0)% OFF"
        discountLabel?.textColor = AndesStyleSheetManager.styleSheet.textColorPositive

        discountLabelLeadingConstraint?.constant = 0.0
        image?.removeFromSuperview()
        image = nil

        let maxSize: CGFloat = 32
        if config.showIcon && size > maxSize {
            FatalErrorUtil.fatalErrorClosure("This size is not valid for discount with icon", #file, #line)
        } else if config.showIcon {
            createImage()
        }
    }

    private func getSizeFor(_ size: AndesMoneyAmountSize, isForSuperScript: Bool) -> CGFloat? {
        let sizeString = AndesMoneyAmountSize.keyFor(size)
        guard let size = NumberFormatter().number(from: sizeString) else { return nil }
        return CGFloat(truncating: size)
    }

    private func getIconSizeFor(_ size: AndesMoneyAmountSize) -> CGFloat? {
        return AndesMoneyAmountSize.iconSizeFor(size)
    }
}
