//
//  AndesModalBodyCollectionViewCell.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 24/05/22.
//

import UIKit

protocol AndesModalBodyCollectionViewCellDelegate: NSObjectProtocol {
    func bodyCollectionViewCellDidTouchDissmisButton(_ cell: AndesModalBodyCollectionViewCell)
    func bodyCollectionViewCell(_ cell: AndesModalBodyCollectionViewCell, didTouch label: AndesLabelType, linkAt index: Int)
}

class AndesModalBodyCollectionViewCell: UICollectionViewCell {
    private var body: AndesModalBodyView?

    weak var delegate: AndesModalBodyCollectionViewCellDelegate?
    var showTitleShadownOnStartScrolling = true

    override func prepareForReuse() {
        super.prepareForReuse()
        alpha = 1
    }

    func setSource(_ source: AndesModalContent, with configuration: AndesModalViewConfig) {
        body?.removeFromSuperview()
        let body = AndesModalBodyView(config: configuration)
        body.bodyDelegate = self
        body.closeButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)
        body.showTitleShadownOnStartScrolling = showTitleShadownOnStartScrolling
        body.source = source
        contentView.addSubview(body)
        body.pinToSuperview()
        body.updateLayout()
        self.body = body
    }

    func resetScroll() {
        guard let scroll = body, scroll.contentSize.height > scroll.frame.height  else { return }
        scroll.setContentOffset(.zero, animated: true)
    }

    @IBAction private func didTouchDissmisButton() {
        delegate?.bodyCollectionViewCellDidTouchDissmisButton(self)
    }
}

extension AndesModalBodyCollectionViewCell: AndesModalBodyViewDelegate {
    func modalBody(_ body: AndesModalBodyView, didTouchLink index: Int, at label: AndesLabelType) {
        self.delegate?.bodyCollectionViewCell(self, didTouch: label, linkAt: index)
    }
}
