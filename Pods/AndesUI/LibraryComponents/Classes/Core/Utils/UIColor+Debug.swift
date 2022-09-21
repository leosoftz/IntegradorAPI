//
//  UIColor+Clear.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 05/03/2022.
//

import Foundation

extension UIColor {
    static func clear(debug: UIColor) -> UIColor {
        let defaults = UserDefaults.standard
        if  defaults.bool(forKey: "debugUIViewMode") == true {
           return debug
        }
        return clear
    }
}
