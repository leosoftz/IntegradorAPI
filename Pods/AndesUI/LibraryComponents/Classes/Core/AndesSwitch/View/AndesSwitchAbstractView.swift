//
//  
//  AndesSwitchAbstractView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import UIKit

class AndesSwitchAbstractView: UIView, AndesSwitchView {
    @IBOutlet var componentView: UIView!
    @IBOutlet var leftSwitch: UISwitch!
    @IBOutlet var rightSwitch: UISwitch!
    @IBOutlet var labelSwitch: UILabel!
    @IBOutlet var rightSwitchView: UIView!
    @IBOutlet var leftSwitchView: UIView!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    @IBOutlet var rigthConstraint: NSLayoutConstraint!
    @IBOutlet var leadingSwitchConstraint: NSLayoutConstraint!

    var config: AndesSwitchViewConfig
    weak var delegate: AndesSwitchViewDelegate?

    init(withConfig config: AndesSwitchViewConfig, delegate: AndesSwitchViewDelegate? = nil) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesSwitchViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesSwitchViewConfig) {
        self.config = config
        updateView()
    }

    private func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.pinToSuperview()
    }

    private func setup() {
        loadNib()
        pinXibViewToSelf()
        updateView()
    }

    private func configureSwitch(_ currentSwitch: UISwitch) {
        currentSwitch.isUserInteractionEnabled = false
        currentSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.71)
    }

    private func configureGesturesForView(_ view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        view.addGestureRecognizer(swipe)

        view.isUserInteractionEnabled = config.type.isEnabled
    }

    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        changeStatus()
    }

    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        changeStatus()
    }

    public func changeStatus() {
        delegate?.OnStatusChange()
    }

    func updateView() {
        labelSwitch.text = config.text
        setupSwitchView()
        labelSwitch.numberOfLines = config.titleNumberOfLines
        leftSwitch.tintColor = AndesStyleSheetManager.styleSheet.bgColorSecondary
        rightSwitch.tintColor = AndesStyleSheetManager.styleSheet.bgColorSecondary
    }

    private func setupSwitchView() {
        labelSwitch.isHidden = labelSwitch.text?.isEmpty ?? true
        labelSwitch.textAlignment = config.align == .left ? .left : .right
        labelSwitch.tintColor = config.type.textColor
        setUpSwitchsWith(config.align)

        switch config.align {
        case .left:
            configureGesturesForView(leftSwitchView)
            configureSwitch(leftSwitch)
        case .right:
            configureGesturesForView(rightSwitchView)
            configureSwitch(rightSwitch)
        }
    }

    private func setUpSwitchsWith(_ align: AndesSwitchAlign) {
        leftConstraint.priority = align == .left ? .defaultLow : .defaultHigh
        rigthConstraint.priority = align == .right ? .defaultLow : .defaultHigh
        leadingSwitchConstraint.priority = align == .left ? .defaultHigh : .defaultLow
        leftSwitchView.isHidden = align == .right
        rightSwitchView.isHidden = align == .left
        configureUISwitchWith(align == .right ? rightSwitch : leftSwitch)
    }

    private func configureUISwitchWith(_ uiSwitch: UISwitch) {
        uiSwitch.setOn(config.isOn, animated: true)
        uiSwitch.isEnabled = config.type.isEnabled
        uiSwitch.tintColor = config.type.tintColor
    }
}
