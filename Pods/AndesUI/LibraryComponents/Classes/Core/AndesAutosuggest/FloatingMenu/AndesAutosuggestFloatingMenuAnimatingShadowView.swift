//
//  AndesAutosuggestFloatingMenuAnimatingShadowView.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 27/06/2021.
//

import UIKit

class AndesAutosuggestFloatingMenuAnimatingShadowView: UIView {
//    Animating a shadow view is realy hard, this was taken from
//    https://stackoverflow.com/questions/43944020/animating-calayer-shadow-simultaneously-as-uitableviewcell-height-animates
//    I guess is ok ... but probably want to make a better solution, is kinda buggy

    private class ShadowingViewAction: NSObject, CAAction {
        var pendingAnimation: CABasicAnimation?
        var priorPath: CGPath?
        // CAAction Protocol
        func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable: Any]?) {
            guard let layer = anObject as? CALayer, let animation = self.pendingAnimation else {
                return
            }
            animation.fromValue = self.priorPath
            animation.toValue = layer.shadowPath
            layer.add(animation, forKey: "shadowPath")
        }
    }

    struct DropShadowParameters {
        var shadowOpacity: Float = 0.3
        var shadowColor: UIColor? = UIColor.Andes.graySolid800
        var shadowRadius: CGFloat = 6
        var shadowOffset: CGSize = CGSize.zero
        static let defaultParameters = DropShadowParameters(shadowOpacity: 0.3,
                                                            shadowColor: UIColor.Andes.graySolid800,
                                                            shadowRadius: 6,
                                                            shadowOffset: CGSize.zero)
    }
    var contentView: UIView!  // no sense in have a shadowView without content!
    var shadowParameters: DropShadowParameters = DropShadowParameters.defaultParameters

    private func apply(dropShadow: DropShadowParameters) {
        let layer = self.layer
        layer.shadowColor = dropShadow.shadowColor?.cgColor
        layer.shadowOffset = dropShadow.shadowOffset
        layer.shadowOpacity = dropShadow.shadowOpacity
        layer.shadowRadius = dropShadow.shadowRadius
        layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = self.layer
        layer.backgroundColor = nil
        let contentLayer = self.contentView.layer

        assert(contentLayer.superlayer == layer, "contentView must be a direct subview of AnimatingShadowView!")

        self.apply(dropShadow: self.shadowParameters)
        let radius = contentLayer.cornerRadius
        layer.shadowPath = UIBezierPath(roundedRect: contentLayer.frame, cornerRadius: radius).cgPath
    }

    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        guard event == "shadowPath" else {
            return super.action(for: layer, forKey: event)
        }
        guard let priorPath = layer.shadowPath else {
            return super.action(for: layer, forKey: event)
        }
        guard let sizeAnimation = layer.animation(forKey: "bounds.size") as? CABasicAnimation else {
            return super.action(for: layer, forKey: event)
        }
        let animation = sizeAnimation.copy() as! CABasicAnimation
        animation.keyPath = "shadowPath"
        let action = ShadowingViewAction()
        action.priorPath = priorPath
        action.pendingAnimation = animation
        return action
    }
}
