//
//  AndesCheckboxDefaultView.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/15/20.
//

import Foundation

class AndesCheckboxDefaultView: UIView, AndesCheckboxView {
    @IBOutlet var label: UILabel!

	@IBOutlet var labelToTopConstraint: NSLayoutConstraint!
	@IBOutlet var labelToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var labelToTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var rightBoxToTopConstraint: NSLayoutConstraint!
    @IBOutlet var leftBoxToTopConstraint: NSLayoutConstraint!

    @IBOutlet var leftBox: UIImageView!
    @IBOutlet var rightBox: UIImageView!

    @IBOutlet var tappableArea: UIButton!

    @IBOutlet var checkboxView: UIView!

    weak var delegate: AndesCheckboxViewDelegate?

    var config: AndesCheckboxViewConfig

    init(withConfig config: AndesCheckboxViewConfig, delegate: AndesCheckboxViewDelegate) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    func update(withConfig config: AndesCheckboxViewConfig) {
        self.config = config
        updateView()
    }

    @IBAction func checkboxTapped(_ sender: Any) {
        self.delegate?.checkboxTapped()
    }

    func loadNib() {
       let bundle = AndesBundle.bundle()
       bundle.loadNibNamed("AndesCheckboxDefaultView", owner: self, options: nil)
    }

    override init(frame: CGRect) {
        self.config = AndesCheckboxViewConfig()
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        self.config = AndesCheckboxViewConfig()
        super.init(coder: coder)
        setup()
    }

    init() {
        self.config = AndesCheckboxViewConfig()
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        loadNib()
        self.addSubview(checkboxView)
        checkboxView.pinToSuperview()
        checkboxView.translatesAutoresizingMaskIntoConstraints = false
        initialize()
        updateView()
    }

    func initialize() {
        self.label.setAndesStyle(style: AndesStyleSheetManager.styleSheet.bodyM(color: config.textColor))
        self.label.isAccessibilityElement = false
    }

    func updateView() {
        clearView()
        self.label.text = config.title
        self.label.numberOfLines = config.titleNumberOfLines
        self.label.lineBreakMode = .byTruncatingTail
        self.label.setContentHuggingPriority(.required, for: .horizontal)
        self.label.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.label.setContentHuggingPriority(.required, for: .vertical)
        self.label.setContentCompressionResistancePriority(.required, for: .vertical)
        updateBoxesViews()
        updateBoxesBorders()
        updateIcons()
    }

    func updateIcons() {
        if let currentIcon = config.icon, !currentIcon.isEmpty {
            if let currentIconColor = config.iconColor {
                if self.leftBox.isHidden == false {
                    AndesIconsProvider.loadIcon(name: currentIcon) { checkboxIcon in
                        self.leftBox.image = checkboxIcon
                    }
                    self.leftBox.tintColor = currentIconColor
                } else {
                    AndesIconsProvider.loadIcon(name: currentIcon) { checkboxIcon in
                        self.rightBox.image = checkboxIcon
                    }
                    self.rightBox.tintColor = currentIconColor
                }
            }
        }
    }

    func updateBoxesViews() {
        let constraint = AndesCheckboxConstraintFactory.retrieveConstraints(align: config.align, context: config.context)

        if config.context == .textField {
            self.label.setContentCompressionResistancePriority(.required, for: .horizontal)
            self.label.setContentHuggingPriority(.required, for: .horizontal)
        }

        switch config.align {
        case .left:
            self.rightBox.isHidden = true
            self.leftBox.isHidden = false
            self.leftBox.backgroundColor = config.backgroundColor
            self.leftBox.layer.cornerRadius = config.cornerRadius

            // Avoids label and check overlapping
            self.labelToLeadingConstraint.constant = constraint.labelToLeadingConstraint
            // Adjust the leading label to show behind the hidden right check box
            self.labelToTrailingConstraint.constant = constraint.labelToTrailingConstraint

            // Align correctly the box to the fontSize (And not the lineHeight)
            self.rightBoxToTopConstraint.constant = 0
            if label.text == nil || label.text?.isEmpty == true {
                self.leftBoxToTopConstraint.constant = -self.labelToTopConstraint.constant
            } else {
                self.leftBoxToTopConstraint.constant = self.label.fontSpacing
            }

        case .right:
            self.rightBox.isHidden = false
            self.leftBox.isHidden = true
            self.rightBox.backgroundColor = config.backgroundColor
            self.rightBox.layer.cornerRadius = config.cornerRadius

            // Adjust the leading label to show behind the hidden left check box
            self.labelToLeadingConstraint.constant = constraint.labelToLeadingConstraint
            // Avoids label and check overlapping
            self.labelToTrailingConstraint.constant = constraint.labelToTrailingConstraint

            // Align correctly the box to the fontSize (And not the lineHeight)
            self.leftBoxToTopConstraint.constant = 0
            if label.text == nil || label.text?.isEmpty == true {
                self.rightBoxToTopConstraint.constant = -self.labelToTopConstraint.constant
            } else {
                self.rightBoxToTopConstraint.constant = self.label.fontSpacing
            }
        }
    }

    func updateBoxesBorders() {
        if let currentBorderColor = config.borderColor, let currentBorderSize = config.borderSize {
            if !self.leftBox.isHidden {
                self.leftBox.layer.borderColor = currentBorderColor.cgColor
                self.leftBox.layer.borderWidth = currentBorderSize
            } else {
                self.rightBox.layer.borderColor = currentBorderColor.cgColor
                self.rightBox.layer.borderWidth = currentBorderSize
            }
        }
    }

    func clearView() {
        self.leftBox.layer.borderColor = UIColor.clear.cgColor
        self.rightBox.layer.borderColor = UIColor.clear.cgColor
        self.leftBox.layer.borderWidth = 0
        self.rightBox.layer.borderWidth = 0
        self.leftBox.image = nil
        self.rightBox.image = nil
    }
}
