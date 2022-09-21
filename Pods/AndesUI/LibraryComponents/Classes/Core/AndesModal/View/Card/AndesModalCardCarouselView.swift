//
//  AndesModalCardCarrouselView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 24/05/22.
//

import UIKit
import PureLayout

class AndesModalCardCarouselView: UIView, AndesModalView {
    private let animator = AndesModalCardAnimator()
    private let cellIdentifier = "card-collection-view-cell"
    private let containerView = UIView()
    private let pageControl = AndesPageControlView()
    private let config: AndesModalViewConfig
    private let configPerPage: AndesModalViewConfig

    private var currentPage: Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.size.width)
    }

    var preferredStatusBarStyle: UIStatusBarStyle = .default
    weak var delegate: AndesModalViewDelegate?

    private let dismissButton = AndesModalCloseButton()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    init(with config: AndesModalViewConfig) {
        dismissButton.isHidden = !config.options.allowsCloseButton
        self.config = config

        self.configPerPage = AndesModalViewConfig(options: config.options, with: .init())
        self.config.options.allowsCloseButton = false

        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AndesModalBodyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        layoutMargins = .zero
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = config.layout.backgroundColor

        preferredStatusBarStyle = .lightContent

        dismissButton.tintColor = UIColor.Andes.white
        dismissButton.alignRight()
        dismissButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)

        addSubview(dismissButton)
        setupConstraints(to: containerView)

        pageControl.delegate = self
        pageControl.isAccessibilityElement = true

        NotificationCenter.default
                .addObserver(self, selector: #selector(voiceOverStatusDidChange), name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)
    }

    func calculateMaxPageHeight() -> CGFloat {
        var minHeight = CGFloat.zero
        for page in config.options.pages {
            let body = AndesModalBodyView(config: configPerPage)
            body.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - config.layout.margins.horizontally)

            body.source = page
            body.updateLayout()
            body.setNeedsLayout()
            body.layoutIfNeeded()
            minHeight = max(minHeight, body.intrinsicContentSize.height)
        }
        return minHeight
    }

    func setupConstraints(to contentView: UIView) {
        pageControl.pages = config.options.pages.count

        containerView.backgroundColor = .red
        contentView.removeFromSuperview()
        containerView.addSubview(collectionView)
        containerView.addSubview(pageControl)

        let height = calculateMaxPageHeight()
        collectionView.autoSetDimension(.height, toSize: height).priority = .defaultLow
        collectionView.autoPinEdge(toSuperviewMargin: .top)
        collectionView.autoPinEdge(toSuperviewMargin: .leading)
        collectionView.autoPinEdge(toSuperviewMargin: .trailing)
        collectionView.autoPinEdge(.bottom, to: .top, of: pageControl, withOffset: -24)

        pageControl.autoPinEdge(toSuperviewMargin: .leading)
        pageControl.autoPinEdge(toSuperviewMargin: .trailing)

        if let footer = config.footerView {
            containerView.addSubview(footer)
            footer.autoPinEdge(.top, to: .bottom, of: pageControl, withOffset: config.layout.footerMargins.top)
            footer.autoPinEdge(toSuperviewEdge: .leading, withInset: config.layout.margins.left)
            footer.autoPinEdge(toSuperviewEdge: .trailing, withInset: config.layout.margins.right)
            footer.autoPinEdge(toSuperviewEdge: .bottom, withInset: config.layout.footerMargins.bottom)
        } else {
            pageControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: config.layout.footerMargins.bottom)
        }

        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = config.layout.cornerRadius
        containerView.backgroundColor = UIColor.Andes.white

        containerView.layoutMargins = .zero
        addSubview(containerView)

        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: config.layout.margins.left, relation: .equal)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: config.layout.margins.left, relation: .equal)
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal).priority = .defaultLow
        dismissButton.autoPinEdge(.trailing, to: .trailing, of: contentView)
        dismissButton.autoPinEdge(.bottom, to: .top, of: contentView)

        let buttonSize = AndesModalCloseButton.buttonSize
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: buttonSize),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -buttonSize)
        ])
    }

    @IBAction private func didTouchDissmisButton() {
        animateDisappear()
    }

    @objc private func voiceOverStatusDidChange() {
        collectionView.reloadData()
    }

    override func accessibilityPerformEscape() -> Bool {
        animateDisappear()
        return true
    }

    // MARK: - Modal View
    func animateAppear() {
        animator.animateAppear(
            view: self,
            containerView: containerView,
            dismissButton: dismissButton
        )
    }

    func animateDisappear() {
        animator.animateDisappear(
            view: self,
            containerView: containerView,
            dismissButton: dismissButton
        ) { [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }
}

extension AndesModalCardCarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? AndesModalBodyCollectionViewCell)?.resetScroll()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage(currentPage)
        self.delegate?.andesModalView(self, didPageChangeTo: currentPage)
    }
}

extension AndesModalCardCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UIAccessibility.isVoiceOverRunning ? 1 : config.options.pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = UIAccessibility.isVoiceOverRunning ? IndexPath(row: pageControl.selectedPage, section: 0) : indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: index)
        guard let cell = cell as? AndesModalBodyCollectionViewCell else {
            preconditionFailure("is not type of AndesModalBodyCollectionViewCell")
        }

        let page = config.options.pages[index.row]
        cell.delegate = self
        cell.showTitleShadownOnStartScrolling = false
        cell.setSource(page, with: configPerPage)
        return cell
    }
}

extension AndesModalCardCarouselView: AndesModalBodyCollectionViewCellDelegate {
    func bodyCollectionViewCellDidTouchDissmisButton(_ cell: AndesModalBodyCollectionViewCell) {
        didTouchDissmisButton()
    }

    func bodyCollectionViewCell(_ cell: AndesModalBodyCollectionViewCell, didTouch label: AndesLabelType, linkAt index: Int) {
        delegate?.andesModalView(self, didTouchLink: index, at: label, of: currentPage)
    }
}

extension AndesModalCardCarouselView: AndesPageControlViewDelegate {
    func andesPageControl(_ control: AndesPageControlView, didPageChangeTo page: Int) {
        delegate?.andesModalView(self, didPageChangeTo: page)
        if UIAccessibility.isVoiceOverRunning {
            collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        } else {
            let index = IndexPath(row: page, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        }
    }
}
