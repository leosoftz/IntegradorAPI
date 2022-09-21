//
//  AndesFeedbackScreenHeaderView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/08/2021.
//

import UIKit

class AndesFeedbackScreenHeaderView: UIView {
    private let dataHeader: AndesFeedbackScreenHeader
    private let separator: Bool
    private var gradientView: UIView?
    private let showGradient: Bool
    private let feedbackColor: AndesFeedbackScreenColor
    private let innerMargin: CGFloat = 16
    private let margin: CGFloat = 20
    private let thumbnailHeightSize: CGFloat = 56
    var feedbackThumbnail: AndesThumbnailBadge!

    private lazy var headerImage: UIImageView = {
        let fullImageView = UIImageView(forAutoLayout: ())
        let image = dataHeader.imageView
        fullImageView.image = image
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        return fullImageView
    }()

    private var containerTextView: UIView = {
        let containerView = UIView(forAutoLayout: ())
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()

    private var containerView: UIView = {
        let containerView = UIView(forAutoLayout: ())
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()

    init(dataHeader: AndesFeedbackScreenHeader, separator: Bool, showGradient: Bool, feedbackColor: AndesFeedbackScreenColor) {
        self.dataHeader = dataHeader
        self.separator = separator
        self.showGradient = showGradient
        self.feedbackColor = feedbackColor
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
    }

    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.gradientView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 144)))
        dataHeader.thumbnail != nil ? setupViewWithThumbnail() : setupViewWithImage()
    }

    private func createGradientView() {
        self.gradientView?.frame = CGRect(origin: CGPoint.init(x: 0, y: -56), size: CGSize(width: UIScreen.main.bounds.width, height: 144))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView?.bounds ?? CGRect.zero
        gradientLayer.colors = [UIColor.Andes.green500.cgColor, UIColor.Andes.green500.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.38, 1.0]
        self.gradientView?.layer.addSublayer(gradientLayer)
    }

    private func setupViewWithThumbnail() {
        guard let thumbnail = self.dataHeader.thumbnailView else { return }
        feedbackThumbnail = thumbnail
        if self.showGradient {
            self.createGradientView()
            guard let gradientView = self.gradientView else { return }
            self.addSubview(gradientView)
            setupContainerViewForGradient()
            let textView = self.buildTextBox()
            self.containerTextView.addSubview(textView)
            textView.autoPinEdge(toSuperviewEdge: .leading, withInset: innerMargin)
            textView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
            setupThumbnailForGradient()
            setupContainerTextViewForGradient(thumbnail, textView)
        } else {
            if separator { buildSeparator(distanceFromTop: thumbnail.bounds.height / 2) }
            self.addSubview(thumbnail)
            thumbnail.autoAlignAxis(toSuperviewAxis: .vertical)
            thumbnail.autoPinEdge(.top, to: .top, of: self)
            self.buildTextBox(viewToPin: thumbnail, withOffset: innerMargin)
        }
    }

    private func setupViewWithImage() {
        if separator { buildSeparator(distanceFromTop: headerImage.bounds.height / 2) }
        self.addSubview(headerImage)
        guard let size = dataHeader.sizeIllustration?.size() else { return }
        headerImage.autoSetDimensions(to: size)
        headerImage.autoAlignAxis(toSuperviewAxis: .vertical)
        headerImage.autoPinEdge(.top, to: .top, of: self)
        self.buildTextBox(viewToPin: headerImage, withOffset: innerMargin)
    }

    private func setupContainerViewForGradient() {
        if separator { buildSeparator(distanceFromTop: 0) }
        self.addSubview(self.containerView)
        self.containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        self.containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        self.containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        self.containerView.autoPinEdge(toSuperviewEdge: .bottom)
        self.containerView.backgroundColor = UIColor.clear
        self.containerView.addSubview(self.containerTextView)
        self.containerTextView.autoPinEdge(toSuperviewEdge: .top)
        self.containerTextView.autoPinEdge(toSuperviewEdge: .leading)
    }

    private func setupContainerTextViewForGradient(_ thumbnail: AndesThumbnailBadge, _ textView: UIView) {
        self.containerTextView.autoPinEdge(.trailing, to: .leading, of: thumbnail, withOffset: -innerMargin)
        self.containerTextView.autoPinEdge(toSuperviewEdge: .leading)
        if textView.bounds.height > thumbnailHeightSize {
            textView.autoPinEdge(toSuperviewEdge: .top, withInset: innerMargin)
            textView.autoPinEdge(toSuperviewEdge: .bottom, withInset: innerMargin)
            self.containerTextView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            self.containerTextView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        } else {
            textView.autoAlignAxis(toSuperviewAxis: .horizontal)
            thumbnail.autoPinEdge(toSuperviewEdge: .bottom, withInset: innerMargin)
            self.containerTextView.autoSetDimension(.height, toSize: (innerMargin * 2) + thumbnailHeightSize)
        }
    }

    private func setupThumbnailForGradient() {
        self.containerView.addSubview(feedbackThumbnail)
        feedbackThumbnail.autoPinEdge(toSuperviewEdge: .top, withInset: innerMargin)
        feedbackThumbnail.autoPinEdge(toSuperviewEdge: .trailing, withInset: innerMargin)
        feedbackThumbnail.size = .size56
        feedbackThumbnail.autoSetDimensions(to: CGSize(width: thumbnailHeightSize, height: thumbnailHeightSize))
    }

    private func buildTextBox() -> UIView {
        let feedbackText = self.dataHeader.feedbackText
        let textView = AndesFeedbackScreenTextLeftView(screenData: feedbackText, addBottomMargin: self.separator)
        textView.setNeedsLayout()
        textView.layoutIfNeeded()
        return textView
    }

    private func buildTextBox(viewToPin: UIView, withOffset: CGFloat) {
        let feedbackText = self.dataHeader.feedbackText
        let textView = AndesFeedbackScreenTextView(screenData: feedbackText, feedbackColor: self.feedbackColor, addBottomMargin: self.separator)
        self.addSubview(textView)
        textView.autoPinEdge(.top, to: .bottom, of: viewToPin, withOffset: withOffset)
        textView.autoAlignAxis(toSuperviewAxis: .vertical)
        textView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - margin * 2 - (innerMargin * 2))
        textView.autoPinEdge(.bottom, to: .bottom, of: self)
        textView.setNeedsLayout()
        textView.layoutIfNeeded()
    }

    private func buildSeparator(distanceFromTop: CGFloat) {
        let separatorView = UIView(forAutoLayout: ())
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.Andes.white
        self.addSubview(separatorView)
        separatorView.autoPinEdge(.top, to: .top, of: self, withOffset: distanceFromTop)
        separatorView.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        separatorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        separatorView.autoPinEdge(toSuperviewEdge: .bottom)
        separatorView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        separatorView.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        separatorView.layer.shadowOpacity = 1
        separatorView.layer.shadowRadius = 16
        separatorView.layer.cornerRadius = 6
        separatorView.layer.shouldRasterize = true
        separatorView.layer.rasterizationScale = UIScreen.main.scale
    }
}
