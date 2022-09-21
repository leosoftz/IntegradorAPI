//
//  AndesModalView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//

import UIKit

internal protocol AndesModalView: UIView {
    var preferredStatusBarStyle: UIStatusBarStyle { get }
    var delegate: AndesModalViewDelegate? { get set }
    func animateAppear()
    func animateDisappear()
}

internal protocol AndesModalViewDelegate: NSObjectProtocol {
    func andesModalViewDidDissmis(_ view: AndesModalView)
    func andesModalView(_ view: AndesModalView, didPageChangeTo page: Int)
    func andesModalView(_ view: AndesModalView, didTouchLink index: Int, at label: AndesLabelType, of page: Int)
}
