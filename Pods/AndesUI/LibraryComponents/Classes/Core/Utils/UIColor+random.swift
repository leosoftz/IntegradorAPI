//
//  UIColor+random.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 16/03/2022.
//

import Foundation

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red: .random(),
           green: .random(),
           blue: .random(),
           alpha: 1.0
        )
    }
}
