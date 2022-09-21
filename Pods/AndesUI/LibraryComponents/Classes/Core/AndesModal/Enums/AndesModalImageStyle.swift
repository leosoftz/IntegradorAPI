//
//  AndesModalImageStyle.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import Foundation

@objc
public enum AndesModalImageStyle: Int {
    case thumbnail
    case ilustration80
    case ilustration128
    case ilustration160
    case banner
    case none

    internal var height: CGFloat {
         switch self {
         case .ilustration80: return 80
         case .ilustration128: return 128
         case .ilustration160: return 160
         case .thumbnail: return 80
         case .banner: return 128
         case .none: return 0
         }
    }
}
