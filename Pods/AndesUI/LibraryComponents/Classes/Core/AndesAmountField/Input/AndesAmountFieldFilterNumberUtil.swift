//
//  AndesAmountFieldPasteUtil.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 09/03/2022.
//

 import Foundation

 class AndesAmountFieldFilterNumberUtil {
     let inputConfig: AndesAmountFieldInputConfig
     let characterSet: CharacterSet
     let maxValue: Decimal
     let trimValue: Decimal
     init(inputConfig: AndesAmountFieldInputConfig, maxValue: Decimal) {
         self.maxValue = maxValue
         self.inputConfig = inputConfig
         self.characterSet = CharacterSet(charactersIn: "0123456789" + inputConfig.decimalSeparator).inverted
         let processValueAdd = inputConfig.decimalPlaces > 0 ? 1.0 / (NSDecimalNumber(10).raising(toPower: inputConfig.decimalPlaces) as Decimal) : Decimal(0)
         self.trimValue = self.maxValue + processValueAdd
     }

     internal func clean(inputText: String) -> (Decimal) {
         let one = self.process(inputText: inputText)
         let second = self.takefirstSeparator(inputText: one)
         let three = self.limitCharNumber(inputText: second)
         return three
     }

     private func process(inputText: String) -> String {
            let numberToClean = inputText
            let cleanNumberStr = numberToClean.replacingOccurrences(of: self.inputConfig.groupingSeparator, with: "", options: .literal, range: nil)
             .components(separatedBy: characterSet).joined()
             return cleanNumberStr
     }

     private  func takefirstSeparator(inputText: String) -> String {
         let numberToClean = inputText
         if let index = numberToClean.firstIndex(of: Character(inputConfig.decimalSeparator)) {
             let secondPart = numberToClean.suffix(from: numberToClean.index(after: index))
             if let secondIndex = secondPart.firstIndex(of: Character(inputConfig.decimalSeparator)) {
                 return String(numberToClean[numberToClean.startIndex..<secondIndex])
             }
             return numberToClean
         }
         return numberToClean
     }

     private func takeOffDecimal(inputText: String) -> String {
         let numberToClean = inputText
         if let index = numberToClean.firstIndex(of: Character(inputConfig.decimalSeparator)) {
             let secondPart = numberToClean.suffix(from: numberToClean.index(after: index))
             let max = self.inputConfig.decimalPlaces
             var offset = 0
             switch secondPart.count {
             case let x where x >= max:
                    offset = max
             case let x where x == 1:
                    offset = 1
             case let x where x == 0:
                return String(numberToClean[numberToClean.startIndex..<index])
             default:
                 return ""
             }
             let endIndex = secondPart.index(secondPart.startIndex, offsetBy: offset)
             let trimmed = String(numberToClean[numberToClean.startIndex...index]) + String(secondPart[secondPart.startIndex..<endIndex])
             return trimmed
         }
         return numberToClean
     }

     internal func limitCharNumber(inputText: String) -> Decimal {
         var limitedNumber: Decimal = 0
         let overflow = self.toDecimal(inputText: inputText) > self.trimValue
         if overflow {
             let trimmed = takeOffDecimal(inputText: self.trim(inputText))
             limitedNumber = self.toDecimal(inputText: trimmed)
         } else {
             let trimmed = takeOffDecimal(inputText: inputText)
             limitedNumber = self.toDecimal(inputText: trimmed)
         }
         return (limitedNumber)
     }

     public func trim(_ toTrim: String) -> String {
         var trimmed: String = ""
         var index: Int = 0
         let arrayToTrim: Array = Array(toTrim)

         repeat {
             trimmed = trimmed + String(arrayToTrim[index])
             index = index + 1
         } while ((self.toDecimal(inputText: trimmed) < self.trimValue) && (index < arrayToTrim.count))
         return trimmed
     }

     private func toDecimal(inputText: String) -> Decimal {
         let numberToClean = inputText.replacingOccurrences(of: inputConfig.decimalSeparator, with: ".")
         return  Decimal(string: numberToClean, locale: Locale(identifier: "en_US")) ?? Decimal(0)
     }
 }
