//
//  AndesColor.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 05/12/2019.
//

import Foundation

@objc extension UIColor {
    /// Andes Color Palette
    @objc(AndesColors) public class Andes: NSObject {
        @objc public static let white = UIColor(hex: "#FFFFFF")!

        @objc public static let gray040 = UIColor(hex: "#0A000000")!
        @objc public static let gray070 = UIColor(hex: "#12000000")!
        @objc public static let gray100 = UIColor(hex: "#1A000000")!
        @objc public static let gray250 = UIColor(hex: "#40000000")!
        @objc public static let gray450 = UIColor(hex: "#73000000")!
        @objc public static let gray550 = UIColor(hex: "#8C000000")!
        @objc public static let gray800 = UIColor(hex: "#CC000000")!
        @objc public static let gray900 = UIColor(hex: "#E6000000")!

        @objc public static let graySolid040 = UIColor(hex: "#F5F5F5")!
        @objc public static let graySolid070 = UIColor(hex: "#EDEDED")!
        @objc public static let graySolid100 = UIColor(hex: "#E5E5E5")!
        @objc public static let graySolid250 = UIColor(hex: "#B5B5B5")!
        @objc public static let graySolid450 = UIColor(hex: "#8C8C8C")!
        @objc public static let graySolid550 = UIColor(hex: "#737373")!
        @objc public static let graySolid800 = UIColor(hex: "#333333")!
        @objc public static let graySolid900 = UIColor(hex: "#1A1A1A")!

        @objc public static let yellowML500 = UIColor(hex: "#FFE602")!

        @objc public static let blueML100 = UIColor(hex: "#1A4189E6")!
        @objc public static let blueML150 = UIColor(hex: "#264189E6")!
        @objc public static let blueML200 = UIColor(hex: "#334189E6")!
        @objc public static let blueML300 = UIColor(hex: "#4D4189E6")!
        @objc public static let blueML400 = UIColor(hex: "#664189E6")!
        @objc public static let blueML500 = UIColor(hex: "#3483FA")!
        @objc public static let blueML600 = UIColor(hex: "#2968C8")!
        @objc public static let blueML700 = UIColor(hex: "#1F4E96")!
        @objc public static let blueML800 = UIColor(hex: "#183C73")!

        @objc public static let blueMP100 = UIColor(hex: "#1A479AD1")!
        @objc public static let blueMP150 = UIColor(hex: "#26479AD1")!
        @objc public static let blueMP200 = UIColor(hex: "#33479AD1")!
        @objc public static let blueMP300 = UIColor(hex: "#4D479AD1")!
        @objc public static let blueMP400 = UIColor(hex: "#66479AD1")!
        @objc public static let blueMP500 = UIColor(hex: "#009EE3")!
        @objc public static let blueMP600 = UIColor(hex: "#007EB5")!
        @objc public static let blueMP700 = UIColor(hex: "#005E88")!
        @objc public static let blueMP800 = UIColor(hex: "#004766")!

        @objc public static let green100 = UIColor(hex: "#1A00A650")!
        @objc public static let green150 = UIColor(hex: "#2600A650")!
        @objc public static let green200 = UIColor(hex: "#3300A650")!
        @objc public static let green300 = UIColor(hex: "#4D00A650")!
        @objc public static let green400 = UIColor(hex: "#6600A650")!
        @objc public static let green500 = UIColor(hex: "#00A650")!
        @objc public static let green600 = UIColor(hex: "#008744")!
        @objc public static let green700 = UIColor(hex: "#006633")!
        @objc public static let green800 = UIColor(hex: "#004D27")!

        @objc public static let orange100 = UIColor(hex: "#1AFF7733")!
        @objc public static let orange150 = UIColor(hex: "#26FF7733")!
        @objc public static let orange200 = UIColor(hex: "#33FF7733")!
        @objc public static let orange300 = UIColor(hex: "#4DFF7733")!
        @objc public static let orange400 = UIColor(hex: "#66FF7733")!
        @objc public static let orange500 = UIColor(hex: "#FF7733")!
        @objc public static let orange600 = UIColor(hex: "#E6540B")!
        @objc public static let orange700 = UIColor(hex: "#CC3E0A")!
        @objc public static let orange800 = UIColor(hex: "#A62A08")!

        @objc public static let red100 = UIColor(hex: "#1AF23D4F")!
        @objc public static let red150 = UIColor(hex: "#26F23D4F")!
        @objc public static let red200 = UIColor(hex: "#33F23D4F")!
        @objc public static let red300 = UIColor(hex: "#4DF23D4F")!
        @objc public static let red400 = UIColor(hex: "#66F23D4F")!
        @objc public static let red500 = UIColor(hex: "#F23D4F")!
        @objc public static let red600 = UIColor(hex: "#D12440")!
        @objc public static let red700 = UIColor(hex: "#A61D33")!
        @objc public static let red800 = UIColor(hex: "#801627")!

        /// Secondary Colors
        @objc public static let secondaryA100 = UIColor(hex: "#FDD5ED")!
        @objc public static let secondaryA200 = UIColor(hex: "#FCC7E6")!
        @objc public static let secondaryA300 = UIColor(hex: "#FAABDA")!
        @objc public static let secondaryA400 = UIColor(hex: "#F98FCD")!
        @objc public static let secondaryA500 = UIColor(hex: "#F773C1")!
        @objc public static let secondaryA600 = UIColor(hex: "#D9539E")!
        @objc public static let secondaryA700 = UIColor(hex: "#BB4A86")!
        @objc public static let secondaryA800 = UIColor(hex: "#9D416F")!
        @objc public static let secondaryA900 = UIColor(hex: "#7F375D")!
        @objc public static let secondaryB100 = UIColor(hex: "#F6D0F4")!
        @objc public static let secondaryB200 = UIColor(hex: "#F3BFF0")!
        @objc public static let secondaryB300 = UIColor(hex: "#ECA0E9")!
        @objc public static let secondaryB400 = UIColor(hex: "#E680E1")!
        @objc public static let secondaryB500 = UIColor(hex: "#E060DA")!
        @objc public static let secondaryB600 = UIColor(hex: "#BF46B9")!
        @objc public static let secondaryB700 = UIColor(hex: "#A43E9E")!
        @objc public static let secondaryB800 = UIColor(hex: "#893685")!
        @objc public static let secondaryB900 = UIColor(hex: "#6E2E6A")!
        @objc public static let secondaryC100 = UIColor(hex: "#ECCBF9")!
        @objc public static let secondaryC200 = UIColor(hex: "#E5B9F7")!
        @objc public static let secondaryC300 = UIColor(hex: "#D896F3")!
        @objc public static let secondaryC400 = UIColor(hex: "#CC73EF")!
        @objc public static let secondaryC500 = UIColor(hex: "#BF50EB")!
        @objc public static let secondaryC600 = UIColor(hex: "#9B3ACB")!
        @objc public static let secondaryC700 = UIColor(hex: "#8533AF")!
        @objc public static let secondaryC800 = UIColor(hex: "#6E2D93")!
        @objc public static let secondaryC900 = UIColor(hex: "#5C2676")!
        @objc public static let secondaryD100 = UIColor(hex: "#DFCCFB")!
        @objc public static let secondaryD200 = UIColor(hex: "#D4BBF9")!
        @objc public static let secondaryD300 = UIColor(hex: "#BE99F6")!
        @objc public static let secondaryD400 = UIColor(hex: "#A977F3")!
        @objc public static let secondaryD500 = UIColor(hex: "#9355F0")!
        @objc public static let secondaryD600 = UIColor(hex: "#6D3ED0")!
        @objc public static let secondaryD700 = UIColor(hex: "#5E36B3")!
        @objc public static let secondaryD800 = UIColor(hex: "#523097")!
        @objc public static let secondaryD900 = UIColor(hex: "#46297A")!
        @objc public static let secondaryE100 = UIColor(hex: "#D1CEFC")!
        @objc public static let secondaryE200 = UIColor(hex: "#C1BDFB")!
        @objc public static let secondaryE300 = UIColor(hex: "#A19DF9")!
        @objc public static let secondaryE400 = UIColor(hex: "#827CF7")!
        @objc public static let secondaryE500 = UIColor(hex: "#635BF5")!
        @objc public static let secondaryE600 = UIColor(hex: "#4742D6")!
        @objc public static let secondaryE700 = UIColor(hex: "#3F3AB8")!
        @objc public static let secondaryE800 = UIColor(hex: "#37339B")!
        @objc public static let secondaryE900 = UIColor(hex: "#2F2C7D")!
        @objc public static let secondaryF100 = UIColor(hex: "#C4D3FC")!
        @objc public static let secondaryF200 = UIColor(hex: "#B0C4FB")!
        @objc public static let secondaryF300 = UIColor(hex: "#88A6F9")!
        @objc public static let secondaryF400 = UIColor(hex: "#6088F7")!
        @objc public static let secondaryF500 = UIColor(hex: "#386BF5")!
        @objc public static let secondaryF600 = UIColor(hex: "#294ED6")!
        @objc public static let secondaryF700 = UIColor(hex: "#2445B8")!
        @objc public static let secondaryF800 = UIColor(hex: "#1F3C9B")!
        @objc public static let secondaryF900 = UIColor(hex: "#1B337D")!
        @objc public static let secondaryG100 = UIColor(hex: "#C6E7FD")!
        @objc public static let secondaryG200 = UIColor(hex: "#B2DEFC")!
        @objc public static let secondaryG300 = UIColor(hex: "#8BCEFA")!
        @objc public static let secondaryG400 = UIColor(hex: "#64BEF9")!
        @objc public static let secondaryG500 = UIColor(hex: "#3EADF7")!
        @objc public static let secondaryG600 = UIColor(hex: "#2D88D9")!
        @objc public static let secondaryG700 = UIColor(hex: "#2873BB")!
        @objc public static let secondaryG800 = UIColor(hex: "#23619D")!
        @objc public static let secondaryG900 = UIColor(hex: "#1E537F")!
        @objc public static let secondaryH100 = UIColor(hex: "#C2F6F2")!
        @objc public static let secondaryH200 = UIColor(hex: "#ADF2ED")!
        @objc public static let secondaryH300 = UIColor(hex: "#83EBE4")!
        @objc public static let secondaryH400 = UIColor(hex: "#5AE4DB")!
        @objc public static let secondaryH500 = UIColor(hex: "#31DED2")!
        @objc public static let secondaryH600 = UIColor(hex: "#23BDB0")!
        @objc public static let secondaryH700 = UIColor(hex: "#1FA397")!
        @objc public static let secondaryH800 = UIColor(hex: "#1B887D")!
        @objc public static let secondaryH900 = UIColor(hex: "#176D65")!
        @objc public static let secondaryI100 = UIColor(hex: "#C5F5D2")!
        @objc public static let secondaryI200 = UIColor(hex: "#B2F1C2")!
        @objc public static let secondaryI300 = UIColor(hex: "#8BEAA4")!
        @objc public static let secondaryI400 = UIColor(hex: "#64E286")!
        @objc public static let secondaryI500 = UIColor(hex: "#3DDB68")!
        @objc public static let secondaryI600 = UIColor(hex: "#2CBB4B")!
        @objc public static let secondaryI700 = UIColor(hex: "#279F42")!
        @objc public static let secondaryI800 = UIColor(hex: "#22863A")!
        @objc public static let secondaryI900 = UIColor(hex: "#1E6A32")!
        @objc public static let secondaryJ100 = UIColor(hex: "#DDF7CC")!
        @objc public static let secondaryJ200 = UIColor(hex: "#D0F4BA")!
        @objc public static let secondaryJ300 = UIColor(hex: "#B9EF98")!
        @objc public static let secondaryJ400 = UIColor(hex: "#A2EA75")!
        @objc public static let secondaryJ500 = UIColor(hex: "#8BE453")!
        @objc public static let secondaryJ600 = UIColor(hex: "#64C43C")!
        @objc public static let secondaryJ700 = UIColor(hex: "#59A735")!
        @objc public static let secondaryJ800 = UIColor(hex: "#4E8D2E")!
        @objc public static let secondaryJ900 = UIColor(hex: "#427128")!
        @objc public static let secondaryK100 = UIColor(hex: "#FFF1CB")!
        @objc public static let secondaryK200 = UIColor(hex: "#FFEBBA")!
        @objc public static let secondaryK300 = UIColor(hex: "#FFE297")!
        @objc public static let secondaryK400 = UIColor(hex: "#FFD874")!
        @objc public static let secondaryK500 = UIColor(hex: "#FFCE52")!
        @objc public static let secondaryK600 = UIColor(hex: "#E1AC3B")!
        @objc public static let secondaryK700 = UIColor(hex: "#C29335")!
        @objc public static let secondaryK800 = UIColor(hex: "#A47B2E")!
        @objc public static let secondaryK900 = UIColor(hex: "#856327")!
        @objc public static let secondaryL100 = UIColor(hex: "#FFE9CB")!
        @objc public static let secondaryL200 = UIColor(hex: "#FFE1BA")!
        @objc public static let secondaryL300 = UIColor(hex: "#FFD297")!
        @objc public static let secondaryL400 = UIColor(hex: "#FFC374")!
        @objc public static let secondaryL500 = UIColor(hex: "#FFB452")!
        @objc public static let secondaryL600 = UIColor(hex: "#E18F3B")!
        @objc public static let secondaryL700 = UIColor(hex: "#C27A35")!
        @objc public static let secondaryL800 = UIColor(hex: "#A4652E")!
        @objc public static let secondaryL900 = UIColor(hex: "#855627")!
    }
}

internal extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }

    /// init UIColor with hex code
    /// - Parameter hex: color representation, e.g: "#FFFFFF" or with alpha "#FF000000"
    convenience init?(hex: String) {
        var cString: String = hex.uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        guard (cString.count == 6 || cString.count == 8) &&
            Scanner(string: cString).scanHexInt64(&rgbValue) else {
            return nil
        }
        if cString.count == 6 {
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else {
            self.init(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        }
    }
}
