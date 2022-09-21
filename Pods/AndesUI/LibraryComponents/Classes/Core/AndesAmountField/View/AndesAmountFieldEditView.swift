//
//  AndesAmountFieldEditView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 23/02/2022.
//

import UIKit

class AndesAmountFieldEditView: UIView {
    enum CursorPosition {
        case left
        case right
    }

    weak var refreshableView: AndesAmountFieldRefreshableView?

    private var isCursorAlwaysToTheRight = false
    private lazy var stackView: UIStackView = buildStackView()
    private lazy var baseAlignmentStackView: UIStackView = buildStackView()
    private let currencyView: AndesAmountFieldCurrencyView?
    private let editableNumberView: AndesAmountFieldEditableNumberView
    private let suffixView: AndesAmountFieldSuffixView?
    private var separatorViewsColor = UIColor.clear(debug: .cyan.withAlphaComponent(0.3))
    private let spacerBegin = UIView(forAutoLayout: ())
    private let spacerEnd = UIView(forAutoLayout: ())
    private var format: AndesAmountFieldFormatEnum = .large

    private var cursor = UIView(forAutoLayout: ())
    private var blinkStatus: Bool?
    private var constraintCursorLeft: NSLayoutConstraint?
    private var constraintCursorRight: NSLayoutConstraint?
    private var layoutConstraints: [NSLayoutConstraint]?

    private(set) var text = ""
    private let type: AndesAmountFieldType

    private var enable = true

    private var isInitial = true

    private let animationStepTime = 0.05

    public var cursorPosition: CursorPosition = .left {
        didSet {
            self.updateCursorPosition()
        }
    }

    public func hideCursor() {
        self.blinkStatus = nil
        self.cursor.alpha = 0
        self.blink()
    }

    public func showCursor() {
        self.blinkStatus = true
        self.blink()
    }
    init(type: AndesAmountFieldType, textConfig: AndesAmountFieldTextConfig, isCursorAlwaysToTheRight: Bool) {
        self.isCursorAlwaysToTheRight = isCursorAlwaysToTheRight
        self.type = type
        let formatConfig = self.format.formatConfig(type: self.type, initial: self.isInitial)

        if let symbolText = textConfig.currencySymbol, type == .currency {
            self.currencyView = AndesAmountFieldCurrencyView(text: symbolText, style: formatConfig.fontStyleCurrency)
        } else {
            self.currencyView = nil
        }
        self.editableNumberView = AndesAmountFieldEditableNumberView(fontStyleTitle: formatConfig.fontStyleCurrency)

        if let suffixText = textConfig.suffixText {
            self.suffixView = AndesAmountFieldSuffixView(text: suffixText, style: formatConfig.fontStyleSuffix)
        } else {
            self.suffixView = nil
        }
        super.init(frame: CGRect.zero)

        self.setupViews()
        self.separatorViewsColor = UIColor.clear(debug: UIColor.green)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 70)
    }

    private func setupViews() {
        self.spacerBegin.backgroundColor = separatorViewsColor
        self.spacerEnd.backgroundColor = separatorViewsColor
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(spacerBegin)
        if let currencyView = self.currencyView {
            self.stackView.addArrangedSubview(currencyView)
        }
        self.baseAlignmentStackView.addArrangedSubview(self.editableNumberView)
        if let suffixView = suffixView {
            self.baseAlignmentStackView.addArrangedSubview(suffixView)
        }

        self.baseAlignmentStackView.alignment = .lastBaseline
        self.baseAlignmentStackView.distribution = .fill

        self.stackView.addArrangedSubview(self.baseAlignmentStackView)

        self.stackView.addArrangedSubview(spacerEnd)
        spacerBegin.autoPinEdge(toSuperviewEdge: .top)
        spacerBegin.autoPinEdge(toSuperviewEdge: .bottom)
        spacerEnd.autoMatch(.height, to: .height, of: spacerBegin)
        spacerEnd.autoMatch(.width, to: .width, of: spacerBegin)
        self.stackView.autoPinEdgesToSuperviewEdges()
        self.setupCursor()

        self.editableNumberView.autoAlignAxis(toSuperviewAxis: .horizontal)

        self.backgroundColor = UIColor.clear(debug: .purple.withAlphaComponent(0.34))

        currencyView?.setContentHuggingPriority(.required, for: .horizontal)
        currencyView?.setContentCompressionResistancePriority(.required, for: .horizontal)
        suffixView?.setContentHuggingPriority(.required, for: .horizontal)
        suffixView?.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private func buildStackView() -> UIStackView {
        let stack = UIStackView(forAutoLayout: ())
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }

    public func update(showText: String, number: Decimal, initial: Bool) {
        guard enable else { return }
        self.isInitial = initial
        self.text = showText
        self.cursorPosition = number == 0 ? (self.isCursorAlwaysToTheRight ? .right : .left ) : .right
        let actualLevel = self.format
        var newLevel = self.format
        if textFitWith(inputText: self.text, actual: actualLevel, new: actualLevel) {
            guard self.format != .large else { return }
            var fit: Bool = true
            var lastFitFormat = actualLevel
            repeat {
                newLevel = newLevel.nextLevel()
                fit = textFitWith(inputText: self.text, actual: actualLevel, new: newLevel)
                if fit { lastFitFormat = newLevel }
            } while fit == true && newLevel != .large
            self.format = lastFitFormat
        } else {
            guard self.format != .extraSmall else { return }
            var fit: Bool = false
            repeat {
                newLevel = newLevel.previousLevel()
                fit = textFitWith(inputText: self.text, actual: actualLevel, new: newLevel)
            } while fit == false && newLevel != .extraSmall
            self.format = newLevel
        }
        self.apply(format: self.format)
    }

    private func textFitWith(inputText: String, actual: AndesAmountFieldFormatEnum, new: AndesAmountFieldFormatEnum) -> Bool {
        self.apply(format: actual)
        self.apply(format: new)
        self.stackView.layoutIfNeeded()
        self.baseAlignmentStackView.layoutIfNeeded()
        let newRemaing = self.spacerBegin.bounds.width + self.spacerEnd.bounds.width
        return newRemaing > 10
    }

    private func apply(format: AndesAmountFieldFormatEnum) {
        let formatConfig = format.formatConfig(type: self.type, initial: self.isInitial)
        currencyView?.update(style: formatConfig.fontStyleCurrency)
        suffixView?.update(style: formatConfig.fontStyleSuffix)
        self.editableNumberView.update(inputText: self.text, style: formatConfig.fontStyleAmount)
        self.stackView.spacing = formatConfig.interSpace
        self.baseAlignmentStackView.spacing = formatConfig.interSpace

        self.currencyView?.setNeedsLayout()
        self.currencyView?.layoutIfNeeded()

        self.suffixView?.setNeedsLayout()
        self.suffixView?.layoutIfNeeded()

        self.editableNumberView.setNeedsLayout()
        self.editableNumberView.layoutIfNeeded()

        self.stackView.setNeedsLayout()
        self.stackView.layoutIfNeeded()

        self.baseAlignmentStackView.setNeedsLayout()
        self.baseAlignmentStackView.layoutIfNeeded()
    }

    public func shake() {
        // the view is animated with a snapshot because the subviews are inside a stackview
        guard enable else { return }
        self.enable = false
        guard let initialColor = self.editableNumberView.textColor,
              initialColor != UIColor.clear else { return }
        self.hideCursor()
        let imageForAnimation = self.editableNumberView.snapshot
        let imageViewForAnimation = UIImageView(image: imageForAnimation)
        self.addSubview(imageViewForAnimation)
        imageViewForAnimation.frame = self.editableNumberView.frame
        self.editableNumberView.textColor = UIColor.clear
        imageViewForAnimation.frame = self.baseAlignmentStackView.convert(self.editableNumberView.frame, to: self)

        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseIn, animations: {
            imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 0, dy: 8)
        }, completion: { _ in
            UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseIn, animations: {
                imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 0, dy: -12)
            }, completion: { _ in
                UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveLinear, animations: {
                    imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 0, dy: 12)
                }, completion: { _ in
                    UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseOut, animations: {
                        imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 0, dy: -8)
                    }, completion: { _ in
                        self.editableNumberView.textColor = initialColor
                        imageViewForAnimation.removeFromSuperview()
                        self.enable = true
                        self.showCursor()
                        self.refresh()
                    })
                })
            })
        })
    }

    public func showAsError() {
        // the view is animated with a snapshot because the subviews are inside a stackview
        guard enable else { return }
        self.enable = false
        var originalPosX: CGFloat = self.convert(self.baseAlignmentStackView.frame, to: self).minX
        if let currencyView = self.currencyView {
            originalPosX = self.convert(currencyView.frame, to: self).minX
        }
        let originalPosY = (self.stackView.bounds.height - self.editableNumberView.bounds.height) / 2
        let numberInitialColor = self.editableNumberView.textColor
        let currencyInitialColor = self.currencyView?.textColor ?? UIColor.clear
        let suffixInitialColor = self.suffixView?.textColor ?? UIColor.clear
        self.hideCursor()
        let numberImage = self.editableNumberView.snapshot
        let currencyImage = self.currencyView?.snapshot ?? UIImage()
        let interSpace = self.stackView.spacing
        let suffixImage = self.suffixView?.snapshot ?? UIImage()
        let suffixPosY = self.suffixView?.frame.origin.y ?? 0
        let imageForAnimation = self.mixCurrencyWithQuantityAndSuffix(imageCurrency: currencyImage, imageNumber: numberImage, imageSuffix: suffixImage, imageSuffixPosY: suffixPosY, interSpace: interSpace)

        let imageViewForAnimation = UIImageView(image: imageForAnimation)
        self.currencyView?.textColor = UIColor.clear
        self.editableNumberView.textColor = UIColor.clear
        self.suffixView?.textColor = UIColor.clear
        self.addSubview(imageViewForAnimation)

        imageViewForAnimation.frame = CGRect(origin: CGPoint(x: originalPosX, y: originalPosY), size: imageViewForAnimation.intrinsicContentSize)
        imageViewForAnimation.image = imageViewForAnimation.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)

        UIView.animate(withDuration: animationStepTime, delay: 0, options: .curveEaseIn, animations: {
            imageViewForAnimation.tintColor = AndesLabelColor.negative.color
            imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: -8, dy: 0)
        }, completion: { _ in
            UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveLinear, animations: {
                imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 16, dy: 0)
            }, completion: { _ in
                UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveLinear, animations: {
                    imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: -16, dy: 0)
                }, completion: { _ in
                    UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveLinear, animations: {
                        imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: 16, dy: 0)
                    }, completion: { _ in
                        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseOut, animations: {
                                imageViewForAnimation.tintColor = numberInitialColor
                                imageViewForAnimation.frame = imageViewForAnimation.frame.offsetBy(dx: -8, dy: 0)
                           }, completion: { _ in
                                self.editableNumberView.textColor = numberInitialColor
                                self.currencyView?.textColor = currencyInitialColor
                                self.suffixView?.textColor = suffixInitialColor
                                imageViewForAnimation.removeFromSuperview()
                                self.showCursor()
                                self.enable = true
                                self.refresh()
                           })
                    })
                })
            })
        })
    }

    private  func mixCurrencyWithQuantityAndSuffix(imageCurrency: UIImage, imageNumber: UIImage, imageSuffix: UIImage, imageSuffixPosY: CGFloat, interSpace: CGFloat) -> UIImage {
        let newWidth = imageCurrency.size.width + interSpace + imageNumber.size.width + interSpace + imageSuffix.size.width
        let newHeight = imageNumber.size.height
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        let middleHeightCurrency = (newHeight - imageCurrency.size.height) / 2
        imageCurrency.draw(in: CGRect(origin: CGPoint(x: 0, y: middleHeightCurrency), size: imageCurrency.size))
        let initialXQuantity = imageCurrency.size.width + interSpace
        imageNumber.draw(in: CGRect(origin: CGPoint(x: initialXQuantity, y: 0), size: imageNumber.size))
        let initialXSuffix = initialXQuantity + interSpace + imageNumber.size.width
        imageSuffix.draw(in: CGRect(origin: CGPoint(x: initialXSuffix, y: imageSuffixPosY), size: imageSuffix.size))
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return newImage
        }
        return UIImage()
    }

    private func setupCursor() {
        super.addSubview(self.cursor)
        let size: CGFloat = 1.0
        self.cursor.autoPinEdge(toSuperviewEdge: .top)
        self.cursor.autoPinEdge(toSuperviewEdge: .bottom)
        self.cursor.autoSetDimension(.width, toSize: size)
        self.constraintCursorRight = self.cursor.autoPinEdge(.trailing, to: .trailing, of: self.editableNumberView, withOffset: 0)
        self.constraintCursorLeft = self.cursor.autoPinEdge(.leading, to: .leading, of: self.editableNumberView, withOffset: 0)
        self.updateCursorPosition()
        self.cursor.backgroundColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        self.blinkStatus = true
        self.blink()
    }

    private func blink() {
        Timer.scheduledTimer(withTimeInterval: 0.9, repeats: true) { timer in
            if self.blinkStatus != nil {
                self.cursor.alpha = self.blinkStatus! ? 1 : 0
                self.blinkStatus?.toggle()
            } else {
                self.cursor.alpha = 0
                timer.invalidate()
            }
        }
    }

    private func updateCursorPosition() {
        switch self.cursorPosition {
            case .right:
                self.constraintCursorRight?.isActive = true
                self.constraintCursorLeft?.isActive = false
            case .left:
                self.constraintCursorRight?.isActive = false
                self.constraintCursorLeft?.isActive = true
        }
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    func valuesTextForA11y() -> AndesAmountFieldViewValues {
        return AndesAmountFieldViewValues(suffixText: self.suffixView?.text,
                                          currencyText: self.currencyView?.text,
                                          helperText: nil,
                                          numberText: self.editableNumberView.text)
    }

    func enableA11yEditNumberView(enable: Bool) {
        self.editableNumberView.a11y(enable: enable)
    }
}

extension AndesAmountFieldEditView: AndesAmountFieldRefreshableView {
    func refresh() {
        self.refreshableView?.refresh()
    }
}
