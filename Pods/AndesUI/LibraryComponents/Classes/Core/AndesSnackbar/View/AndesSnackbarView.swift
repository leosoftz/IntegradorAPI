//
//  AndesSnackbarView.swift
//  AndesUI
//
//  Created by Samuel Sainz on 6/15/20.
//

import UIKit

class AndesSnackbarView: UIView, AndesSnackbarViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var snackbarView: UIView!
    @IBOutlet private var snackbarTextLabel: UILabel!
    @IBOutlet private var snackbarActionButton: AndesButton!
    @IBOutlet private var snackbarErrorCodeLabel: UILabel!
    @IBOutlet private var errorCodeStackView: UIStackView!

    // MARK: - Constraints
    @IBOutlet var buttonOnTrailingConstraints: [NSLayoutConstraint]!
    @IBOutlet var buttonOnBottomLeadingConstraints: [NSLayoutConstraint]!
    @IBOutlet var hideButtonConstraints: [NSLayoutConstraint]!

    // MARK: - Propierties
    weak var delegate: AndesSnackbarViewDelegate?
    var config: AndesSnackbarViewConfig
    var styleSheet: AndesStyleSheet = AndesStyleSheetManager.styleSheet

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        config = AndesSnackbarViewConfig()
        super.init(frame: frame)
        setup()
    }

    init(withConfig config: AndesSnackbarViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesSnackbarViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesSnackbarView", owner: self, options: nil)
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        setupView()
        updateView()
    }

    func updateButtonsLayout() {
        if self.config.actionConfig != nil {
            let height = self.snackbarTextLabel.text?.height(withConstrainedWidth: self.snackbarTextLabel.frame.size.width, font: self.snackbarTextLabel.font)
            let lineCount = Int((height ?? 0) / self.snackbarTextLabel.font.lineHeight)

            if lineCount > 1 {
                layoutButtonOnSnackbarBottomLeading()
            } else {
                layoutButtonOnSnackbarTrailing()
            }
        } else {
            hideButton()
        }
        if self.config.errorCode == nil {
            errorCodeStackView.isHidden = true
        }
        self.layoutIfNeeded()
    }

    func layoutButtonOnSnackbarTrailing() {
        self.snackbarActionButton.isHidden = false
        for constraint in self.buttonOnBottomLeadingConstraints {
            constraint.priority = .defaultLow
        }
        for constraint in self.buttonOnTrailingConstraints {
            constraint.priority = .defaultHigh
        }
    }

    func layoutButtonOnSnackbarBottomLeading() {
        self.snackbarActionButton.isHidden = false
        for constraint in self.buttonOnTrailingConstraints {
            constraint.priority = .defaultLow
        }
        for constraint in self.buttonOnBottomLeadingConstraints {
            constraint.priority = .defaultHigh
        }
    }

    func hideButton() {
        self.snackbarActionButton.isHidden = true
        for constraint in self.hideButtonConstraints {
            constraint.priority = UILayoutPriority(999) // required
        }
    }

    func update(withConfig config: AndesSnackbarViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(snackbarView)
        snackbarView.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: snackbarView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: snackbarView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: snackbarView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: snackbarView.bottomAnchor).isActive = true
    }

    func updateView() {
        self.backgroundColor = config.backgroundColor

        self.snackbarTextLabel.text = config.text

        if let actionConfig = config.actionConfig {
            self.snackbarActionButton.updateWithCustomConfig(actionConfig)
        }

        if config.errorCode != nil {
            setupErrorCodeLabelTextWithAttributes()
        }
    }

    // MARK: - Actions
    @IBAction func snackbarActionTapped(_ sender: Any) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.actionButtonTapped()
    }
}

// MARK: - Setup View
extension AndesSnackbarView {
    private func setupView() {
        setupSnackbarLabel()
        setupErrorCodeLabel()
    }

    private func setupSnackbarLabel() {
        self.layer.cornerRadius = 6.0
        self.snackbarTextLabel.textColor = UIColor.Andes.white
        self.snackbarTextLabel.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14.0)
    }

    private func setupErrorCodeLabel() {
        snackbarErrorCodeLabel.layer.backgroundColor = UIColor.Andes.white.withAlphaComponent(0.15).cgColor
        snackbarErrorCodeLabel.layer.cornerRadius = 10
        snackbarErrorCodeLabel.layer.masksToBounds = false
        snackbarErrorCodeLabel.textAlignment = .center
        setupErrorCodeLabelTextWithAttributes()
    }

    private func setupErrorCodeLabelTextWithAttributes() {
        let codeAttributedString = [NSAttributedString.Key.font: styleSheet.regularSystemFont(size: AndesFontSize.bodyXS),
                                    NSAttributedString.Key.foregroundColor: UIColor.Andes.white]
        let errorAttributedString = [NSAttributedString.Key.font: styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyXS),
                                     NSAttributedString.Key.foregroundColor: UIColor.Andes.white]

        let codeStyleSetup = NSMutableAttributedString(string: "error_code".localized(),
                                                       attributes: codeAttributedString)
        let errorStyleSetup = NSMutableAttributedString(string: config.errorCode ?? "",
                                                        attributes: errorAttributedString)

        codeStyleSetup.append(errorStyleSetup)
        self.snackbarErrorCodeLabel.attributedText = codeStyleSetup
    }
}
