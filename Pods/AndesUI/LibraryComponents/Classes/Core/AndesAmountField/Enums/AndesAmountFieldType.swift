//
//  AndesAmountFieldType.swft.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//
import Foundation

@objc
public enum AndesAmountFieldType: Int, AndesEnumStringConvertible {
    case currency
    case percentage

    public static func keyFor(_ value: AndesAmountFieldType) -> String {
        switch value {
        case .currency: return "CURRENCY"
        case .percentage: return "PERCENTAGE"
        }
    }
}
