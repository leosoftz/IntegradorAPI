//
//  AndesBulletView.swift
//  AndesUI
//
//  Created by Martin Ezequiel Becerra on 2/25/21.
//

import UIKit

protocol AndesBulletViewDelegate: AnyObject {
    func andesbulletView(urlInteractionAt linkIndex: Int, forBullet bulletIndex: Int)
}

final class AndesBulletView: UIView, UITextViewDelegate {
    @IBOutlet var bulletView: UIView!
    @IBOutlet var bulletTextView: UITextView!

    var bulletIndex: Int = 0
    weak var delegate: AndesBulletViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    private func setup() {
        self.loadNib()
        self.bulletTextViewSetup()
    }

    private func loadNib() {
        let bundle = AndesBundle.bundle()
        guard let view = bundle.loadNibNamed("AndesBulletView", owner: self, options: nil)?.first as? UIView else {
            return
        }

        view.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    private func bulletTextViewSetup() {
        self.bulletTextView.textContainerInset = .zero
        self.bulletTextView.textContainer.lineFragmentPadding = 0.0
        self.bulletTextView.delegate = self
    }

    func configure(bulletText: NSAttributedString, with andesStyle: AndesFontStyle, linkTextColor: UIColor, delegate: AndesBulletViewDelegate?, at bulletIndex: Int) {
        self.bulletView.backgroundColor = andesStyle.textColor
        self.bulletTextView.setAndesStyle(style: andesStyle)
        self.bulletTextView.attributedText = bulletText
        self.bulletTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: linkTextColor]
        self.bulletIndex = bulletIndex
        self.delegate = delegate
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let index = Int(String(describing: URL)) ?? 0
        self.delegate?.andesbulletView(urlInteractionAt: index, forBullet: self.bulletIndex)
        return false
    }
}
