//
//  AndesFeedbackScreenErrorCodeView.swift
//  AndesUI
//
//  Created by Juan Agustin Aguade Abelenda on 18/2/22.
//

import UIKit

class AndesFeedbackScreenErrorCodeView: UIView {
    // MARK: - Constants
    private enum AndesFeedbackScreenErrorCodeViewConstants {
        static let leftLabelPadding: CGFloat = 8
        static let rightPaddingView: CGFloat = 4
        static let containerStackViewSpacing: CGFloat = 4
        static let cornerRadius: CGFloat = 10
        static let errorLabelHeight: CGFloat = 24
        static let mainViewHeight: CGFloat = 40
    }

    // MARK: - Properties
    private let errorCodeLabel: UILabel = UILabel()
    private var errorContainerStackView: UIStackView = UIStackView()
    private var errorCode: String

    // MARK: - Life Cycle
    public init(errorCode: String) {
        self.errorCode = errorCode
        super.init(frame: CGRect.zero)
        self.buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViews() {
        self.addSubview(setupErrorContainerView())
        errorContainerStackView.addArrangedSubview(setupErrorCodeLabel(errorCode: errorCode))
        errorContainerStackView.addArrangedSubview(setupCopyImage())
        errorContainerStackView.addArrangedSubview(addRightPaddingView())
        setupConstraints()
    }
}

// MARK: - Setup View Styles
extension AndesFeedbackScreenErrorCodeView {
    private func setupErrorContainerView() -> UIStackView {
        errorContainerStackView.axis = .horizontal
        errorContainerStackView.alignment = .center
        errorContainerStackView.spacing = AndesFeedbackScreenErrorCodeViewConstants.containerStackViewSpacing
        errorContainerStackView.distribution = .fillProportionally
        errorContainerStackView.backgroundColor = UIColor.Andes.gray040
        errorContainerStackView.layer.cornerRadius = AndesFeedbackScreenErrorCodeViewConstants.cornerRadius
        errorContainerStackView.isUserInteractionEnabled = true
        addCopyCodeAction()

        return errorContainerStackView
    }

    private func setupErrorCodeLabel(errorCode: String) -> UILabel {
        errorCodeLabel.attributedText = getAttributedTextForErrorCode(errorCode: errorCode)
        errorCodeLabel.numberOfLines = 1
        errorCodeLabel.lineBreakMode = .byWordWrapping
        errorCodeLabel.textAlignment = .center

        return errorCodeLabel
    }

    private func setupCopyImage() -> UIImageView {
        let iconImageView = UIImageView()
        AndesIconsProvider.loadIcon(name: AndesIcons.copy16, placeItInto: iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = AndesStyleSheetManager.styleSheet.accentColor500

        return iconImageView
    }

    // This padding view is added to the stack view in order to guarantee the correct right margin size
    private func addRightPaddingView() -> UIView {
        let paddingView = UIView()
        paddingView.widthAnchor.constraint(equalToConstant: AndesFeedbackScreenErrorCodeViewConstants.rightPaddingView).isActive = true

        return paddingView
    }

    private func getAttributedTextForErrorCode(errorCode: String) -> NSAttributedString {
        let styleSheet: AndesStyleSheet = AndesStyleSheetManager.styleSheet
        let codeAttributedString = [NSAttributedString.Key.font: styleSheet.regularSystemFont(size: AndesFontSize.bodyXS),
                                    NSAttributedString.Key.foregroundColor: styleSheet.textColorSecondary]
        let errorAttributedString = [NSAttributedString.Key.font: styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyXS),
                                     NSAttributedString.Key.foregroundColor: styleSheet.accentColor500]

        let codeStyleSetup = NSMutableAttributedString(string: "error_code".localized(),
                                                       attributes: codeAttributedString)
        let errorStyleSetup = NSMutableAttributedString(string: errorCode,
                                                        attributes: errorAttributedString)

        codeStyleSetup.append(errorStyleSetup)

        return codeStyleSetup
    }
}

// MARK: - Setup Views Constraints
extension AndesFeedbackScreenErrorCodeView {
    private func setupConstraints() {
        setupErrorContainerStackView()
        setupMainViewConstraints()
        setupErroCodeLabelConstraints()
    }

    private func setupErrorContainerStackView() {
        errorContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        errorContainerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        errorContainerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    private func setupErroCodeLabelConstraints() {
        errorCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        errorCodeLabel.heightAnchor.constraint(equalToConstant: AndesFeedbackScreenErrorCodeViewConstants.errorLabelHeight).isActive = true
        errorCodeLabel.widthAnchor.constraint(equalToConstant: errorCodeLabel.intrinsicContentSize.width
                                              + AndesFeedbackScreenErrorCodeViewConstants.leftLabelPadding).isActive = true
        errorCodeLabel.layer.masksToBounds = true
        errorCodeLabel.textAlignment = .right
    }

    private func setupMainViewConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoSetDimension(.height, toSize: AndesFeedbackScreenErrorCodeViewConstants.mainViewHeight)
    }
}

// MARK: - Actions
extension AndesFeedbackScreenErrorCodeView {
    private func addCopyCodeAction() {
        let tapToCopyGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(tappedCopyToClipboardStack))
        errorContainerStackView.addGestureRecognizer(tapToCopyGesture)
        errorContainerStackView.accessibilityIdentifier = "error_container_stack"
    }

    @objc
    func tappedCopyToClipboardStack(_ btn: UIControl) {
        UIPasteboard.general.string = errorCode
    }
}
