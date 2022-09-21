//
//  AndesSliderThumb.swift
//  AndesUI
//
//  Created by Victor Chang on 06/05/2021.
//

import Foundation
import UIKit

class AndesSliderThumb {
    static func setNormalStateThumb(color: UIColor, borderColor: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20))
        let circle = UIBezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 16, height: 16))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.setStrokeColor(borderColor.cgColor)
            ctx.cgContext.setLineWidth(2.5)
            ctx.cgContext.addPath(circle.cgPath)
            ctx.cgContext.drawPath(using: .eoFillStroke)
        }
        return image
    }

    static func setHighlightedThumbWithShadow(color: UIColor, shadowColor: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 28, height: 28))
        let circle = UIBezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 20, height: 20))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.setShadow(offset: CGSize(width: 0, height: 3), blur: 4, color: shadowColor.cgColor)
            ctx.cgContext.addPath(circle.cgPath)
            ctx.cgContext.drawPath(using: .eoFill)
        }
        return image
    }

    static func setHighlightedThumb(color: UIColor, borderColor: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 26, height: 26))
        let circle = UIBezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 20, height: 20))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.setStrokeColor(borderColor.cgColor)
            ctx.cgContext.setShadow(offset: CGSize(width: 0, height: 2), blur: 2.5)
            ctx.cgContext.setLineWidth(2.5)
            ctx.cgContext.addPath(circle.cgPath)
            ctx.cgContext.drawPath(using: .eoFillStroke)
        }
        return image
    }
}
