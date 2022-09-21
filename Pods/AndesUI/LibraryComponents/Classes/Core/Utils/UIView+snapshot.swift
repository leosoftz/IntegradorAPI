//
//  UIView+snapshot.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 05/03/2022.
//

import Foundation

extension UIView {
var snapshot: UIImage {
   return UIGraphicsImageRenderer(size: bounds.size).image { _ in
        drawHierarchy(in: bounds, afterScreenUpdates: true)
   }
}
}
