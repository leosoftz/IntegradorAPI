//
//
//  AndesTooltipAbstractView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import UIKit

class AndesTooltipAbstractView: UIView, AndesTooltipView {
    @IBOutlet private var componentView: UIView!
    @IBOutlet internal var contentLabel: AndesLabel!
    @IBOutlet internal var titleLabel: AndesLabel!
    @IBOutlet internal var closeButton: UIButton!
    @IBOutlet private var closeButtonHeightConstraint: NSLayoutConstraint!

    private(set) var config: AndesTooltipViewConfig
    weak var delegate: AndesTooltipViewDelegate?
    var accessibilityManager: AndesTooltipAccessibilityManager?
    private weak var superView: UIView?

    lazy var tooltip: AndesBaseTooltipView = {
        let tooltip = AndesBaseTooltipView(content: componentView, config: config)
        tooltip.delegate = self
        return tooltip
    }()

    init(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        updateView()
    }

    func show(in view: UIView, within superView: UIView, position: AndesTooltipPosition) {
        self.superView = view
        tooltip.show(target: view, withinSuperview: superView, position: position, sizeStyle: config.sizeStyle)
        accessibilityManager?.makeAnnouncement(type: .custom(notification: .screenChanged, argument: componentView))
        view.accessibilityViewIsModal = true
    }

    func show(in view: UIView, position: AndesTooltipPosition) {
        self.superView = view
        tooltip.show(target: view, position: position, sizeStyle: config.sizeStyle)
        accessibilityManager?.makeAnnouncement(type: .custom(notification: .screenChanged, argument: componentView))
        tooltip.accessibilityViewIsModal = true
    }

    @objc func dismiss() {
        self.tooltip.dismiss()
        accessibilityManager?.removeAccessibility(superView: superView)
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    func updateView() {
        if let andesLabel = config.contentAndesLabel {
            contentLabel.text = andesLabel.text
            contentLabel.accessibilityLabel = andesLabel.accessibilityLabel
        } else {
            contentLabel.text = config.content
            contentLabel.accessibilityLabel = config.content
        }
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = config.contentAlignment
        renderTitleIfNeeded()
        renderCloseButtonIfNeeded()
        contentLabel.setAndesStyle(style: config.getContentStyle())

        accessibilityManager = AndesTooltipAccessibilityManager(view: self)
    }

    private func renderTitleIfNeeded() {
        guard let title = config.title else {
            titleLabel.removeFromSuperview()
            return
        }

        titleLabel.text = title
        titleLabel.accessibilityLabel = config.title
        titleLabel.setAndesStyle(style: config.getTitleStyle())
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = config.titleAlignment
    }

    private func renderCloseButtonIfNeeded() {
        if !config.isDismissable {
            hideCloseButton()
            return
        }
        let closeIcon = AndesIcons.close16
        AndesIconsProvider.loadIcon(name: closeIcon) { image in
            self.closeButton.setImage(image, for: .normal)
            self.closeButton.tintColor = config.closeButtonColor
        }
    }

    private func hideCloseButton() {
        self.closeButtonHeightConstraint.constant = 0
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    @IBAction func closeButtonTapped() {
        self.dismiss()
    }
}

extension AndesTooltipAbstractView: AndesBaseTooltipViewDelegate {
    func andesTooltipViewDismiss() {
        self.dismiss()
    }

    func onDismissed() {
        self.delegate?.onDismissed()
    }
}
