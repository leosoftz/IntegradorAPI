//
//  AndesCarouselAbstractView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 09/02/2021.
//

import UIKit

class AndesCarouselAbstractView: UIView, AndesCarouselView {
    struct InfinityScrollManager {
        var isEnabled: Bool = true
        var isFirstScroll = false
        let boundaryEdges = 2
        var bufferWidth: CGFloat = 0.0
        var bufferInsets: UIEdgeInsets = .zero
    }

    var collectionView: UICollectionView!
    var titleLabel: UILabel?
    var pageControl: AndesPageControlView!
    weak var delegate: AndesCarouselViewProtocol?
    var infinityScroll = InfinityScrollManager()
    var config: AndesCarouselViewConfig
    let andesCarouselCellID = "andesCarouselCellID"
    var titleLabelRigthConstraint: NSLayoutConstraint?
    var autoScrollTimer: Timer?
    var currentIndexPath: IndexPath?

    var isInfinityScrollEnabled: Bool {
        infinityScroll.isEnabled && !UIAccessibility.isVoiceOverRunning
    }

    var isAutoScrollEnabled: Bool {
        config.isAutoScroll && !UIAccessibility.isReduceMotionEnabled
    }

    init(withConfig config: AndesCarouselViewConfig, delegate: AndesCarouselViewProtocol? = nil) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func cleanView() {
        if collectionView != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        if let titleLabel = titleLabel {
            titleLabel.removeFromSuperview()
            self.titleLabel = nil
        }
        if let pageControl = pageControl {
            pageControl.removeFromSuperview()
            self.pageControl = nil
        }
    }

    func update(withConfig config: AndesCarouselViewConfig) {
        self.config = config
        cleanView()
        setup()
    }

    internal func setup() {
        self.clipsToBounds = true
        self.backgroundColor = .clear
        addNotificaitons()
        createTitleLabel()
        createCollectionView()
        addPaginator()
        self.infinityScroll.isEnabled = self.config.isInfinityScroll
        autoScrollTimer?.invalidate()
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: config.autoScrollSpeed, repeats: true, block: { [weak self] _ in
            self?.autoScroll()
        })
    }

    fileprivate func createTitleLabel() {
        if !self.config.title.isEmpty {
            titleLabel = UILabel()

            if let titleLabel = self.titleLabel {
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.font = AndesStyleSheetManager.styleSheet.titleXS(color: AndesStyleSheetManager.styleSheet.textColorPrimary).font
                titleLabel.text = self.config.title
                self.addSubview(titleLabel)
                titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.config.margin).isActive = true
                titleLabelRigthConstraint = titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.config.margin)
                titleLabelRigthConstraint?.isActive = true
                titleLabel.sizeToFit()

                titleLabel.isAccessibilityElement = true
                titleLabel.accessibilityHint = "title of section"
            }
        }
    }

    fileprivate func createCollectionView() {
        infinityScroll.isFirstScroll = false
        translatesAutoresizingMaskIntoConstraints = false

        let collectionLayout = self.config.centerScroll ? AndesCollectionViewFlowLayout() : UICollectionViewFlowLayout()

        if let collectionLayout = collectionLayout as? AndesCollectionViewFlowLayout {
            collectionLayout.delegate = self
        }
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = self.config.cellSpacing
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: andesCarouselCellID)
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.addSubview(collectionView)

        collectionView.addObserver(self,
                                   forKeyPath: "contentSize",
                                   options: NSKeyValueObservingOptions.old,
                                   context: nil)
        var topConstraint: CGFloat = 0
        if let titleLabel = self.titleLabel {
            let titleBottomPadding: CGFloat = 8
            topConstraint = titleLabel.frame.height.rounded(.up) + titleBottomPadding
        }
        collectionView.pinToSuperview(top: topConstraint, left: 0, bottom: 0, right: 0)
    }

    fileprivate func addPaginator() {
        if self.config.usePaginator {
            pageControl = AndesPageControlView(frame: .zero)
            pageControl.pages = delegate?.numberOfRow() ?? 1
            self.addSubview(pageControl)
            positionPageControl()

            pageControl.isAccessibilityElement = true
        }
    }

    internal func roundContentView( cell: UICollectionViewCell) {
        // Override if you need change roundContent
        cell.contentView.layer.roundContentView(with: 2.0, isMaskToBounds: true)
    }

    internal func applyShadowContetView( cell: UICollectionViewCell) {
        // Override if you need it in your view
    }

    internal func positionPageControl() {
        fatalError("This should be overriden by a subclass")
    }

    internal func getContentInset(_ section: Int) -> UIEdgeInsets {
        fatalError("This should be overriden by a subclass")
    }

    internal func getItemSize(sizeForItemAt indexPath: IndexPath) -> CGSize {
        fatalError("This should be overriden by a subclass")
    }

    private func addNotificaitons() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadForVoiceOver),
                                               name: UIAccessibility.voiceOverStatusDidChangeNotification,
                                               object: nil)
    }

    @objc func reloadForVoiceOver() {
        collectionView?.reloadData()
        scrollToFirst()
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let observedObject = object as? UICollectionView, observedObject == collectionView, !infinityScroll.isFirstScroll {
            infinityScroll.isFirstScroll = true
            scrollToFirst()
        }
    }

    private func scrollToFirst(animated: Bool = false) {
        let row = isInfinityScrollEnabled ? infinityScroll.boundaryEdges : 0
        scrollToElement(at: IndexPath(row: row, section: 0), animated: animated)
    }

    func autoScroll() {
        if let currentIndexPath = currentIndexPath,
           isAutoScrollEnabled && isInfinityScrollEnabled {
            let indexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            scrollToElement(at: indexPath, animated: true)
            self.currentIndexPath = indexPath
            setPageControlIndex(indexPath)
        }
    }

    fileprivate func setPageControlIndex(_ indexPath: IndexPath) {
        if let pageControl = pageControl {
            let originalIndex = indexPathForBoundary(indexPath: indexPath)
            delegate?.indexNumberChanged(indexPath: originalIndex)
            pageControl.currentPage(originalIndex.row)
        }
    }
}

extension AndesCarouselAbstractView: UICollectionViewDataSource {
    private var numberOfItems: Int {
        (delegate?.numberOfRow() ?? 0)
    }

    private var boundaryNumberOfItem: Int {
        numberOfItems + (isInfinityScrollEnabled ? (infinityScroll.boundaryEdges * 2) : 0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        boundaryNumberOfItem
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let boundaryIndexPath = indexPathForBoundary(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: andesCarouselCellID, for: boundaryIndexPath)
        cell.backgroundColor = .clear

        for view in cell.subviews {
            view.removeFromSuperview()
        }

        roundContentView(cell: cell)
        applyShadowContetView(cell: cell)

        let cellView = getCellView(indexPath: boundaryIndexPath)
        cell.addSubview(cellView)
        cellView.pinToSuperview()

        return cell
    }

    func getCellView(indexPath: IndexPath) -> UIView {
        return (delegate?.cellForRowAt(indexPath: indexPath)) ?? UIView()
    }

    private func indexPathForBoundary(indexPath: IndexPath) -> IndexPath {
        guard isInfinityScrollEnabled else { return indexPath }
        var row: Int = 0
        if indexPath.row < infinityScroll.boundaryEdges {
            row = (numberOfItems - infinityScroll.boundaryEdges) + indexPath.row
        } else if indexPath.row < numberOfItems + infinityScroll.boundaryEdges {
            row = indexPath.row - infinityScroll.boundaryEdges
        } else {
            row = indexPath.row - (numberOfItems + infinityScroll.boundaryEdges)
        }
        return IndexPath(row: row, section: indexPath.section)
    }

    private  func scrollToElement(at indexPath: IndexPath, animated: Bool = false) {
        guard numberOfItems > 0 else { return }
        let scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally
        collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        guard !animated, let offset = (collectionView.collectionViewLayout as? AndesCollectionViewFlowLayout)?
            .targetContentOffset(forProposedContentOffset: collectionView.contentOffset,
                                 withScrollingVelocity: .zero) else { return }
        collectionView.contentOffset = offset
    }
}

extension AndesCarouselAbstractView: UICollectionViewDelegate, AndesCollectionViewFlowLayoutDelegate {
    func didSwitchTo(newIndex: IndexPath) {
        self.currentIndexPath = newIndex
        setPageControlIndex(newIndex)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

extension AndesCarouselAbstractView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = getItemSize(sizeForItemAt: indexPath)
        infinityScroll.bufferWidth = size.width
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = getContentInset(section)
        infinityScroll.bufferInsets = inset
        return inset
    }
}

extension AndesCarouselAbstractView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isInfinityScrollEnabled else { return }

        let cellSize = infinityScroll.bufferWidth
        let numberOfBoundaryElements = CGFloat(infinityScroll.boundaryEdges)
        let padding: CGFloat = (collectionView.collectionViewLayout as? AndesCollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
        let scrollViewContentSizeValue = scrollView.contentSize.width
        let dataSetCount = CGFloat(numberOfItems)

        let boundarySize = numberOfBoundaryElements * cellSize + (numberOfBoundaryElements * padding)
        let contentOffsetValue = scrollView.contentOffset.x
        let insetSpacing: CGFloat = padding
        if contentOffsetValue >= (scrollViewContentSizeValue - boundarySize) - insetSpacing {
            let offset = boundarySize + insetSpacing * 2
            let updatedOffsetPoint = CGPoint(x: offset, y: 0)
            scrollView.contentOffset = updatedOffsetPoint
            currentIndexPath = IndexPath(row: infinityScroll.boundaryEdges + 1, section: 0)
        } else if contentOffsetValue <= (cellSize + padding) {
            let boundaryLessSize = contentOffsetValue + (dataSetCount * cellSize) + (dataSetCount * padding)
            let updatedOffsetPoint = CGPoint(x: boundaryLessSize, y: 0)
            scrollView.contentOffset = updatedOffsetPoint
        }
    }
}
