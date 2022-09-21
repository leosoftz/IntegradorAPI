//
//  ViewControllerUtils.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 13/09/2021.
//

import Foundation

class ViewControllerUtils {
    static func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
}
