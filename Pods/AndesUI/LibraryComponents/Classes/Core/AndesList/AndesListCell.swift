//
//  AndesListCell.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 16/10/20.
//

import UIKit

/**
 This class is a custom cell to AndesUI
 - Requires: See the AndesSimpleCell and AndesChevronCell documentation for integration
 - Important: This class cannot be initialize
*/
@objc public class AndesListCell: UITableViewCell, AndesAccessibleView {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subtitleLbl: UILabel!
    @IBOutlet var descriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet var paddingLeftConstraint: NSLayoutConstraint!
    @IBOutlet var paddingRightConstraint: NSLayoutConstraint!
    @IBOutlet var paddingTopConstraint: NSLayoutConstraint!
    @IBOutlet var paddingBottomConstraint: NSLayoutConstraint!
    @IBOutlet var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var thumbnailImg: AndesThumbnail!
    @IBOutlet var thumbnailWidthConstraint: NSLayoutConstraint!
    @IBOutlet var thumbnailHeightConstraint: NSLayoutConstraint!
    @IBOutlet var iconImg: UIImageView!
    @IBOutlet var iconView: UIView!
    @IBOutlet var iconImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet var iconImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var spaceThumbnailWidthConstraint: NSLayoutConstraint!
    @IBOutlet var paddingTopThumbnailConstraint: NSLayoutConstraint!
    @IBOutlet var paddingBottomThumbnailConstraint: NSLayoutConstraint!

    @IBOutlet var thumbStack: UIStackView!

    var title: String = String()
    var subtitle: String = String()
    var row: Int = -1
    @objc public internal(set) var type: AndesCellType = .simple
    var accessibilityManager: AndesAccessibilityManager?

    var fontStyle: AndesFontStyle = AndesFontStyle(textColor: .black,
                                                          font: UIFont.boldSystemFont(ofSize: 16),
                                                          lineSpacing: 2)
    var fontSubTitleStyle: AndesFontStyle = AndesFontStyle(textColor: .black,
                                                                     font: UIFont.boldSystemFont(ofSize: 16),
                                                                     lineSpacing: 2)
    var paddingLeftCell: CGFloat = 0
    var paddingRightCell: CGFloat = 0
    var paddingTopCell: CGFloat = 0
    var paddingBottomCell: CGFloat = 0
    var subTitleHeight: CGFloat = 0
    var separatorHeight: CGFloat = 0
    var heightConstraint: CGFloat = 0
    var titleHeight: CGFloat = 0
    var chevron: String?
    var chevronSize: CGFloat? = 0
    var thumbnailLeft: UIImage?
    var thumbnailSize: CGFloat?
    var separatorThumbnailWidth: CGFloat? = 0
    var paddingTopThumbnail: CGFloat? = 0
    var paddingBottomThumbnail: CGFloat? = 0
    var separatorChevronWidth: CGFloat? = 0
    var paddingTopChevron: CGFloat? = 0
    var paddingBottomChevron: CGFloat? = 0
    var numberOfLines: Int = 0
    var thumbnail: AndesThumbnail?
    var paddingRightSelectionItem: CGFloat? = 0

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init() {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "")
    }

    func setup(customCell: AndesListCell, separatorStyle: AndesSeparatorStyle) {
        self.setupUIComponents(customCell: customCell)
        self.setupSeparatorStyle(separatorStyle: separatorStyle)
        self.setupThumbnail(customCell: customCell)
    }

    func setupUIComponents(customCell: AndesListCell) {
        self.titleLbl.text = customCell.title
        self.type = customCell.type
        self.row = customCell.row
        // TODO improve !! cuando se fix fontStyle
        if customCell.fontStyle.fontLineHeight > 0 {
            self.titleLbl.setAndesStyle(style: customCell.fontStyle, lineHeight: customCell.fontStyle.fontLineHeight)
        } else {
            self.titleLbl.setAndesStyle(style: customCell.fontStyle)
        }
        self.titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: customCell.titleHeight).isActive = true
        self.subtitleLbl.text = customCell.subtitle
        self.subtitleLbl.setAndesStyle(style: customCell.fontSubTitleStyle)
        self.descriptionHeightConstraint.constant = customCell.subTitleHeight
        self.setupConstratints(customCell: customCell)
        self.titleLbl.adjustsFontSizeToFitWidth = false
        self.titleLbl.lineBreakMode = .byTruncatingTail
        self.titleLbl.numberOfLines = customCell.numberOfLines
        self.subtitleLbl.adjustsFontSizeToFitWidth = false
        self.subtitleLbl.lineBreakMode = .byTruncatingTail
    }

    func setupConstratints(customCell: AndesListCell) {
        self.paddingLeftConstraint.constant = customCell.paddingLeftCell
        self.paddingRightConstraint.constant = customCell.paddingRightCell
        self.paddingTopConstraint.constant = customCell.paddingTopCell
        self.paddingBottomConstraint.constant = customCell.paddingBottomCell
        self.separatorHeightConstraint.constant = customCell.separatorHeight

        if customCell.thumbnail != nil {
            self.iconImgWidthConstraint.constant = 0
            self.iconImgHeightConstraint.constant = 0
            self.thumbnailWidthConstraint.constant = 0
            self.thumbnailHeightConstraint.constant = 0
        }
    }

    func setupThumbnail(customCell: AndesListCell) {
        if let imageSize = customCell.thumbnailSize, imageSize != 0.0 {
            self.thumbnailImg.accessibilityDescription = customCell.thumbnail?.accessibilityDescription
            if customCell.thumbnail?.type == .icon {
                self.iconImgWidthConstraint.constant = imageSize
                self.iconImgHeightConstraint.constant = imageSize
                self.thumbnailWidthConstraint.constant = imageSize
                self.thumbnailHeightConstraint.constant = imageSize
                self.iconImg.image = customCell.thumbnailLeft
                self.thumbnailImg.type = customCell.thumbnail?.type ?? .icon
                self.thumbnailImg.isHidden = true
                self.iconView.isHidden = false
            } else {
                self.thumbnailWidthConstraint.constant = imageSize
                self.thumbnailHeightConstraint.constant = imageSize
                self.iconImgWidthConstraint.constant = imageSize
                self.iconImgHeightConstraint.constant = imageSize
                self.thumbnailImg.image = customCell.thumbnailLeft
                self.thumbnailImg.type = customCell.thumbnail?.type ?? .imageCircle
                self.thumbnailImg.size = AndesThumbnailSize.floatToAndesThumbnailSize(value: customCell.thumbnailSize ?? 0)
                self.thumbnailImg.isHidden = false
                self.iconView.isHidden = true
            }
            self.paddingTopThumbnailConstraint.constant = customCell.paddingTopThumbnail ?? 0
            self.paddingBottomThumbnailConstraint.constant = customCell.paddingBottomThumbnail ?? 0
            self.spaceThumbnailWidthConstraint.constant = customCell.separatorThumbnailWidth ?? 0
        } else {
            if self.thumbStack != nil {
                self.thumbStack.removeFromSuperview()
            }
        }
    }

    func setupSeparatorStyle(separatorStyle: AndesSeparatorStyle) {
        switch separatorStyle {
        case .none:
            separatorView.backgroundColor = .clear
        case .singleLine:
            separatorView.backgroundColor = UIColor.Andes.gray100
        }
    }

    func updateSize(size: AndesListSize) {
        fatalError("This should be overriden by a subclass")
    }

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            accessibilityManager = AndesListAccessibilityManager(view: self)
        }
    }
}
