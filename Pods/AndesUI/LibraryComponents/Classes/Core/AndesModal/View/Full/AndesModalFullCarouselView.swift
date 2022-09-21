//
//  AndesModalFullCarouselView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 25/05/22.
//

import UIKit
import PureLayout

class AndesModalFullCarouselView: UIView, AndesModalView {
    private let cellIdentifier = "full-collection-view-cell"
    private let pageControl = AndesPageControlView()
    private let configPerPage: AndesModalViewConfig
    private let animator = AndesModalFullAnimator()
    private var visibleCell: UICollectionViewCell?

    private var currentPage: Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.size.width)
    }

    var preferredStatusBarStyle: UIStatusBarStyle = .default
    let config: AndesModalViewConfig
    weak var delegate: AndesModalViewDelegate?

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
        self.config = config
        self.configPerPage = AndesModalViewConfig(options: config.options, with: .init())

        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }

    func setup() {
        layoutMargins = .zero
        backgroundColor = config.layout.backgroundColor
        pageControl.pages = config.options.pages.count

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AndesModalBodyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        addSubview(collectionView)
        addSubview(pageControl)

        collectionView.autoPinEdge(toSuperviewMargin: .top)
        collectionView.autoPinEdge(toSuperviewMargin: .leading)
        collectionView.autoPinEdge(toSuperviewMargin: .trailing)
        collectionView.autoPinEdge(.bottom, to: .top, of: pageControl, withOffset: -24)

        pageControl.autoPinEdge(toSuperviewMargin: .leading)
        pageControl.autoPinEdge(toSuperviewMargin: .trailing)
        pageControl.delegate = self
        pageControl.isAccessibilityElement = true

        if let footer = config.footerView {
            addSubview(footer)
            footer.autoPinEdge(.top, to: .bottom, of: pageControl, withOffset: config.layout.footerMargins.top)
            footer.autoPinEdge(toSuperviewEdge: .leading, withInset: config.layout.margins.left)
            footer.autoPinEdge(toSuperviewEdge: .trailing, withInset: config.layout.margins.right)
            footer.autoPinEdge(toSuperviewMargin: .bottom, withInset: config.layout.footerMargins.bottom)
        } else {
            pageControl.autoPinEdge(toSuperviewMargin: .bottom, withInset: config.layout.footerMargins.bottom)
        }

        NotificationCenter.default
            .addObserver(self, selector: #selector(voiceOverStatusDidChange), name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)
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
        animator.animateAppear(view: self)
    }

    func animateDisappear() {
        animator.animateDisappear(view: self) {  [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }
}

extension AndesModalFullCarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let cell = collectionView.visibleCells.first else {
            return
        }
        visibleCell = cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cell = visibleCell else {
            return
        }

        let translation = abs(scrollView.panGestureRecognizer.translation(in: self).x)
        let percent = (translation * 1.2) / collectionView.frame.width
        cell.alpha = 1 - percent
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.1) {
            self.collectionView.visibleCells.first?.alpha = 1
        }

        self.pageControl.currentPage(currentPage)
        self.delegate?.andesModalView(self, didPageChangeTo: currentPage)
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? AndesModalBodyCollectionViewCell)?.resetScroll()
    }
}

extension AndesModalFullCarouselView: UICollectionViewDataSource {
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
        cell.showTitleShadownOnStartScrolling = true
        cell.delegate = self
        cell.setSource(page, with: configPerPage)
        return cell
    }
}

extension AndesModalFullCarouselView: AndesModalBodyCollectionViewCellDelegate {
    func bodyCollectionViewCell(_ cell: AndesModalBodyCollectionViewCell, didTouch label: AndesLabelType, linkAt index: Int) {
        delegate?.andesModalView(self, didTouchLink: index, at: label, of: currentPage)
    }

    func bodyCollectionViewCellDidTouchDissmisButton(_ cell: AndesModalBodyCollectionViewCell) {
        didTouchDissmisButton()
    }
}

extension AndesModalFullCarouselView: AndesPageControlViewDelegate {
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
