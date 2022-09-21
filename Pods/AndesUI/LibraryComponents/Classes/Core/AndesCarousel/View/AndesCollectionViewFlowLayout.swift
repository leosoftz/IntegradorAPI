//
//  AndesCollectionViewFlowLayout.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 21/04/2021.
//

import Foundation

protocol AndesCollectionViewFlowLayoutDelegate: AnyObject {
    func didSwitchTo(newIndex: IndexPath)
}

class AndesCollectionViewFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: AndesCollectionViewFlowLayoutDelegate?

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionViewBounds = self.collectionView?.bounds, let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) else { return CGPoint.zero }

        let halfWidthOfVC = collectionViewBounds.size.width * 0.5
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
        var candidateAttribute: UICollectionViewLayoutAttributes?

        for attributes in attributesForVisibleCells {
            let candAttr: UICollectionViewLayoutAttributes? = candidateAttribute
            if candAttr != nil {
                let a = attributes.center.x - proposedContentOffsetCenterX
                let b = candAttr!.center.x - proposedContentOffsetCenterX
                if abs(a) < abs(b) {
                    candidateAttribute = attributes
                }
            } else {
                candidateAttribute = attributes
                continue
            }
        }

        var newPoint = CGPoint.zero
        if let candidateAttribute = candidateAttribute {
            delegate?.didSwitchTo(newIndex: candidateAttribute.indexPath)
            newPoint = CGPoint(x: candidateAttribute.center.x - halfWidthOfVC, y: proposedContentOffset.y)
        }

        return newPoint
    }
}
