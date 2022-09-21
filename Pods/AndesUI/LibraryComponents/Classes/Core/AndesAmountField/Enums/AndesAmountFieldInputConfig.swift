//
//  AndesAmountFieldInputConfig.swft.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

@objc
public class AndesAmountFieldInputConfig: NSObject {
  public let type: AndesAmountFieldType
  public let entryMode: AndesAmountFieldInputMode
  public let decimalSeparator: String
  public let groupingSeparator: String
  public let groupingSize: Int
  public let decimalPlaces: Int

  @objc
  public init(
         type: AndesAmountFieldType,
         entryMode: AndesAmountFieldInputMode,
         decimalSeparator: String,
         groupingSeparator: String,
         groupingSize: Int,
         decimalPlaces: Int) {
        self.type = type
        self.entryMode = entryMode
        self.decimalSeparator = decimalSeparator
        self.groupingSeparator = groupingSeparator
        self.groupingSize = groupingSize
        self.decimalPlaces = decimalPlaces
    }

    override public var description: String {
        return ("Type: \(AndesAmountFieldType.keyFor(self.type)) EntryMode:\(AndesAmountFieldInputMode.keyFor(self.entryMode)) DecimalSeparator:\(self.decimalSeparator) GroupingSeparator:\(self.groupingSeparator) GroupingSize:\(self.groupingSize) DecimalPlaces:\(self.decimalPlaces)")
    }
}
