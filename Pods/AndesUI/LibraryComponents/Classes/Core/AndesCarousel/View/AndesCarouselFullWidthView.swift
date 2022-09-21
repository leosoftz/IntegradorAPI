//
//  AndesCarouselFullWidthView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 23/03/2021.
//

import Foundation

class AndesCarouselFullWidthView: AndesCarouselAbstractView {
    override func setup() {
        super.setup()
        if config.usePaginator, let pageControl = self.pageControl {
            pageControl.selectedColor = .white
        }
    }
    override func getItemSize(sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }

    override func getContentInset(_ section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    override func positionPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
