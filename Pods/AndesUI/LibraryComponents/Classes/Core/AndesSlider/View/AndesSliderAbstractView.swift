//
//
//  AndesSliderAbstractView.swift
//  AndesUI
//
//  Created by Victor Chang on 25/02/2021.
//
//

import UIKit

class AndesSliderAbstractView: UIView, AndesSliderView, SliderAccesibilityDelegate {
    @IBOutlet var componentView: UIView!
    @IBOutlet var sliderView: UISlider!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var tooltipBackgroundView: UIView!
    @IBOutlet var tooltipLabel: UILabel!

    @IBOutlet var tooltipLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var tooltipBottomConstraint: NSLayoutConstraint!
    @IBOutlet var valueLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var valueLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var tooltipTrailingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    weak var delegate: AndesSliderViewDelegate?
    var config: AndesSliderViewConfig
    weak var accessibilitySlider: UIAccessibilitySlider?

    init(withConfig config: AndesSliderViewConfig, delegate: AndesSliderViewDelegate) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
        valueLabel.isAccessibilityElement = false
    }

    // MARK: - View initialization

    required init?(coder: NSCoder) {
        config = AndesSliderViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesSliderAbstractView", owner: self, options: nil)
    }

    override init(frame: CGRect) {
        self.config = AndesSliderViewConfig()
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        componentView.layoutIfNeeded()
        let valuePoint = setSliderThumbValueWithLabel(slider: self.sliderView)
        self.valueLabelLeadingConstraint.constant = valuePoint.x
        super.layoutSubviews()
        accessibilitySlider?.updateLayout(with: 1)
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        let value = sender.value
        let valueLabelPoint = setSliderThumbValueWithLabel(slider: sender)

        valueLabel.text = "\(value)"
        tooltipLabel.text = "\(value)"
        valueLabelLeadingConstraint.constant = valueLabelPoint.x
        delegate?.onValueChanged(value: Double(value), sender: sender)
        setHandleBehaviour()
    }

    @objc fileprivate func setHandleBehaviour() {
        if sliderView.isHighlighted && config.tooltipEnabled == true {
            hideValueLabel()
            showTooltip()
        } else if !sliderView.isHighlighted {
            showValueLabel()
            hideTooltip()
        }
    }

    var sliderAccessibilityValue: String? {
        config.valueText
    }

    func update(withConfig config: AndesSliderViewConfig) {
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
        setupIconsIfNeeded()
        setupSliderColor()
        setupTooltipBackgroundView()
        sliderView.addTarget(self, action: #selector(setHandleBehaviour), for: [.allTouchEvents])
        setupAccessibility()
    }

    func setupIconsIfNeeded() {
        if config.type == .icons {
        sliderView.minimumValueImage = UIImage(named: config.leftIconImageName ?? "andes_ui_restar_16", in: AndesBundle.bundle(), compatibleWith: nil)
        sliderView.maximumValueImage = UIImage(named: config.rightIconImageName ?? "andes_ui_restar_16", in: AndesBundle.bundle(), compatibleWith: nil)
        }
    }

    func setupTooltipBackgroundView() {
        tooltipBackgroundView.alpha = 0
        tooltipBackgroundView.backgroundColor = UIColor.Andes.gray800
        tooltipBackgroundView.layer.cornerRadius = 5
        tooltipBackgroundView.contentMode = .center
    }

    func setupSliderColor() {
        self.sliderView.minimumTrackTintColor = UIColor.Andes.blueML500.withAlphaComponent(0.7)
        self.sliderView.maximumTrackTintColor = UIColor.Andes.gray070
    }

    func updateView() {
        sliderView.value = Float(config.value)
        valueLabel.text = self.config.valueText ?? "\(sliderView.value)"
        tooltipLabel.text = self.config.valueText ?? "\(sliderView.value)"
        sliderView.minimumValue = Float(config.minValue)
        sliderView.maximumValue = Float(config.maxValue)
        setupState()
        setupIconsIfNeeded()
    }

    fileprivate func hideValueLabel() {
        valueLabelTopConstraint.constant = 0
        UIView.animate(withDuration: 0.15) {
            self.valueLabel.alpha = 0
            self.componentView.layoutIfNeeded()
        }
    }

    fileprivate func showValueLabel() {
        valueLabelTopConstraint.constant = 5
        UIView.animate(withDuration: 0.15) {
            self.valueLabel.alpha = 1
            self.componentView.layoutIfNeeded()
        }
    }

    fileprivate func hideTooltip() {
        tooltipBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.15) {
            self.tooltipBackgroundView.alpha = 0
            self.componentView.layoutIfNeeded()
        }
    }

    fileprivate func showTooltip() {
        tooltipBottomConstraint.constant = 6
        UIView.animate(withDuration: 0.15) {
            self.tooltipBackgroundView.alpha = 1
            self.componentView.layoutIfNeeded()
        }
    }

    fileprivate func setupState() {
        if config.state == .idle {
            sliderView.isEnabled = true
            sliderView.minimumTrackTintColor = UIColor.Andes.blueML500.withAlphaComponent(0.7)
            sliderView.maximumTrackTintColor = UIColor.Andes.gray070
        } else if config.state == .disable {
            sliderView.isEnabled = false
            sliderView.minimumTrackTintColor = UIColor.Andes.gray100
            sliderView.maximumTrackTintColor = UIColor.Andes.gray100
            let disabledStateThumb = AndesSliderThumb.setNormalStateThumb(color: UIColor.Andes.white.withAlphaComponent(1.0), borderColor: UIColor.Andes.gray250)
            sliderView.setThumbImage(disabledStateThumb, for: .disabled)
        }
        setThumbImage()
    }

    func setThumbImage() {
        let normalStateThumb = AndesSliderThumb.setNormalStateThumb(color: UIColor.Andes.white, borderColor: UIColor.Andes.blueML500)
        let borderColor = UIColor.Andes.blueML500.withAlphaComponent(0.3)
        let highlightedThumb = AndesSliderThumb.setHighlightedThumb(color: UIColor.Andes.white, borderColor: borderColor)
        let disabledStateThumb = AndesSliderThumb.setNormalStateThumb(color: UIColor.Andes.white.withAlphaComponent(1.0), borderColor: UIColor.Andes.gray250)
        switch config.state {
            case .idle:
                sliderView.setThumbImage(normalStateThumb, for: .normal)
                sliderView.setThumbImage(highlightedThumb, for: .highlighted)
            case .disable:
                sliderView.setThumbImage(disabledStateThumb, for: .disabled)
        }
    }

    func setupAccessibility() {
        let accessibilitySlider = UIAccessibilitySlider(slider: self.sliderView, delegate: self)
        self.accessibilitySlider = accessibilitySlider
    }
}

extension AndesSliderAbstractView {
    fileprivate func setSliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack: CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderThumbFrame: CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        let xValue: CGFloat = (sliderThumbFrame.origin.x + sliderThumbFrame.width / 2 - valueLabel.frame.width / 2).rounded(.up)
        let point = CGPoint(x: xValue, y: valueLabel.center.y)
        return point
    }
}
