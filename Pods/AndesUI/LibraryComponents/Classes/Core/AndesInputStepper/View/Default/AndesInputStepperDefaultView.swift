//
//  AndesInputStepperDefaultView.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 20/01/22.
//

import Foundation
import UIKit

internal class AndesInputStepperDefaultView: AndesInputStepperAbstractView {
    override internal func loadNib() {
        let bundle = AndesBundle.bundle()
        if let view = bundle.loadNibNamed("AndesInputStepperDefaultView", owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
        }
    }
}
