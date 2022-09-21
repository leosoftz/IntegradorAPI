//
//  AndesMessageView.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 1/14/20.
//

import UIKit

class AndesMessageAbstractView: UIView, AndesMessageView, UITextViewDelegate, AndesBulletViewDelegate {
    weak var delegate: AndesMessageViewDelegate?

    @IBOutlet var messageView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var iconContainerView: UIView!
    @IBOutlet var leftPipeView: UIView!
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var titleToDismissConstraint: NSLayoutConstraint!
    @IBOutlet var titleToSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet var bulletStackView: UIStackView!
    @IBOutlet var bulletStackTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet var bulletStackHeightConstraint: NSLayoutConstraint?

    private(set) var config: AndesMessageViewConfig
    init(withConfig config: AndesMessageViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMessageViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesMessageViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: messageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: messageView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: messageView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: messageView.bottomAnchor).isActive = true
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()

        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        messageView.clipsToBounds = true
    }

    @IBAction func dismissPressed(_ sender: Any) {
        self.delegate?.dismissTapped()
    }

    /// Override this method on each Message View to setup its unique components
    func updateView() {
        self.backgroundColor = config.backgroundColor
        self.leftPipeView.backgroundColor = config.pipeColor

        self.bodyTextView.isEditable = true

        self.bodyTextView.setAndesStyle(style: config.bodyStyle)
        self.bodyTextView.attributedText = getBodyText(style: config.bodyStyle)
        self.bodyTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: config.bodyLinkTextColor]
        self.bodyTextView.delegate = self

        self.iconView.tintColor = config.iconColor
        if let icon = config.icon {
            AndesIconsProvider.loadIcon(name: icon, placeItInto: self.iconView)
        }
        self.iconContainerView.backgroundColor = config.iconBackgroundColor

        self.titleLabel.text = config.titleText

        if config.titleText == nil || config.titleText!.isEmpty {
            titleLabel.isHidden = true
        } else {
            self.titleLabel.setAndesStyle(style: config.titleStyle)
            self.titleLabel.text = config.titleText
            self.titleLabel.isHidden = false
        }

        if config.isDismissable, let iconName = config.dismissIconName {
            self.dismissButton.isHidden = false
            self.titleToDismissConstraint.priority = .init(rawValue: 999)
            self.titleToSafeAreaConstraint.priority = .defaultLow
            self.dismissButton.tintColor = config.dismissIconColor
            AndesIconsProvider.loadIcon(name: iconName) {
                self.dismissButton.setImage($0, for: .normal)
            }
        } else {
            self.titleToDismissConstraint.priority = .defaultLow
            self.titleToSafeAreaConstraint.priority = .init(rawValue: 999)
            self.dismissButton.isHidden = true
        }

        self.bulletsSetup()
    }

    func bulletsSetup() {
        self.adjustAndesMessageSpaces()
        self.removeAllBullets()

        for (index, bullet) in self.config.bullets.enumerated() {
            let bulletView = self.mapBulletToView(for: bullet, at: index)
            self.bulletStackView.addArrangedSubview(bulletView)
        }
    }

    func mapBulletToView(for bullet: AndesBullet, at index: Int) -> AndesBulletView {
        let bulletView = AndesBulletView(frame: .zero)
        let bodyStyle = config.bodyStyle
        let bulletText = self.getBodyAttributedText(text: bullet.text, bodyLinks: bullet.bodyLinks)
        bulletView.configure(bulletText: bulletText, with: bodyStyle, linkTextColor: config.bodyLinkTextColor, delegate: self, at: index)
        return bulletView
    }

    func adjustAndesMessageSpaces() {
        let hasBullets = !self.config.bullets.isEmpty
        let bodyEmpty = self.config.bodyText?.isEmpty ?? true

        self.bodyTextView.isHidden = bodyEmpty

        guard hasBullets else { return }

        self.bulletStackHeightConstraint?.isActive = false
        self.bulletStackHeightConstraint = nil

        if bodyEmpty {
            self.bulletStackTopSpaceConstraint.constant = 4.0
        } else {
            self.bulletStackTopSpaceConstraint.constant = 8.0
        }
    }

    func removeAllBullets() {
        let views = self.bulletStackView.arrangedSubviews
        for view in views {
            view.removeFromSuperview()
        }
    }

    func getBodyText(style: AndesFontStyle) -> NSAttributedString {
        let body = config.bodyText ?? ""
        return getBodyAttributedText(text: body, bodyLinks: config.bodyLinks)
    }

    func getBodyAttributedText(text: String, bodyLinks: AndesBodyLinks?) -> NSAttributedString {
        let style = config.bodyStyle
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: style.textColor,
            .paragraphStyle: paragraphStyle,
            .font: style.font
        ]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)

        if let bodyLinks = bodyLinks {
            for (index, link) in bodyLinks.links.enumerated() {
                if link.isValidRange(attributedString) {
                    let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
                    attributedString.addAttribute(.link, value: String(describing: index), range: range)

                    if config.bodyLinkIsUnderline {
                        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                    }
                }
            }
        }

        return attributedString
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let index = Int(String(describing: URL)) ?? 0
        config.bodyLinks?.listener(index)
        return false
    }

    func andesbulletView(urlInteractionAt linkIndex: Int, forBullet bulletIndex: Int) {
        config.bullets[bulletIndex].bodyLinks?.listener(linkIndex)
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
