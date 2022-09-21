//
//  AndesModalImageView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit
import PureLayout

internal class AndesModalImageView: UIView {
    internal let imageAspectRatio: CGFloat = 9.0 / 16.0
    internal let imageView = UIImageView()

    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    var imageStyle: AndesModalImageStyle = .thumbnail {
        didSet {
            updateView()
            invalidateIntrinsicContentSize()
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
        updateView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false

        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateView() {
        imageView.layer.cornerRadius = 0
        imageView.removeFromSuperview()
        imageView.constraints.forEach(imageView.removeConstraint(_:))
        addSubview(imageView)
        switch imageStyle {
        case .thumbnail:
            imageView.layer.cornerRadius = imageStyle.height / 2
            imageView.autoPinEdge(toSuperviewEdge: .bottom)
            imageView.autoAlignAxis(toSuperviewAxis: .vertical)
            imageView.autoSetDimension(.width, toSize: imageStyle.height)
            imageView.autoSetDimension(.height, toSize: imageStyle.height)

        case .banner:
            imageView.autoMatch(.height, to: .width, of: imageView, withMultiplier: imageAspectRatio)
            imageView.autoPinEdge(toSuperviewEdge: .leading)
            imageView.autoPinEdge(toSuperviewEdge: .trailing)
            imageView.autoPinEdge(toSuperviewEdge: .top)
            imageView.autoPinEdge(toSuperviewEdge: .bottom)

        default:
            imageView.autoPinEdgesToSuperviewMargins()
            imageView.autoSetDimension(.height, toSize: imageStyle.height)
        }
    }

    override var intrinsicContentSize: CGSize {
        if isHidden {
            return .zero
        }

        if case .none = imageStyle {
            return .zero
        }
        let height = layoutMargins.vertically + imageStyle.height
        return CGSize(width: super.intrinsicContentSize.width, height: height)
    }
}
