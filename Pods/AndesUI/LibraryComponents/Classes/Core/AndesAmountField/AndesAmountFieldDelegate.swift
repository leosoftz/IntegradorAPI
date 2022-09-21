//
//  AndesAmountFieldDelegate.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 08/04/2022.
//

import Foundation

@objc
public protocol AndesAmountFieldDelegate {
    @objc func amountFieldDidChage(amountField: AndesAmountFieldView, stringValue: String, decimalValue: Decimal)
}

internal protocol AndesAmountFieldRefreshableView: AnyObject {
    func refresh()
}
