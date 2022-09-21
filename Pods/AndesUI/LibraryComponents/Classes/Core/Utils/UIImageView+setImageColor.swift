//
//  UIImageView+setImageColor.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
