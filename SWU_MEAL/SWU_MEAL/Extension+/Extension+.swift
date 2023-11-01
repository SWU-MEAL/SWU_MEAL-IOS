//
//  Extension+.swift
//  FanDoor
//
//  Created by 목정아 on 2023/09/06.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.count == 3 {
            formattedHex = formattedHex.map { "\($0)\($0)" }.joined()
        }
        
        if formattedHex.count == 6 {
            var rgbValue: UInt64 = 0
            Scanner(string: formattedHex).scanHexInt64(&rgbValue)
            
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            self.init(white: 1.0, alpha: alpha)
        }
    }
}

// MARK: - UIImage

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}

// MARK: - UILabel
extension UILabel {
    func dynamicFont(fontSize size: CGFloat) {
        let currentFontName = self.font.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.7)
            break
        case 568.0: //iphone 5, SE => 4 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.8)
            break
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.92)
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 0.95)
            break
        case 812.0: //iphone X, XS => 5.8 inch
            calculatedFont = UIFont(name: currentFontName, size: size)
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            calculatedFont = UIFont(name: currentFontName, size: size * 1.15)
            break
        default:
            print("not an iPhone")
            break
        }
    }
}

// MARK: - UIFont

extension UIFont {
    static func uhbee(size: CGFloat) -> UIFont? {
        return UIFont(name: "UhBeeSe_hyun", size: size)
    }
    
    static func uhbeeBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "UhBeeSe_hyunBold", size: size)
    }
}

// MARK: - UITextField

extension UITextField {
    func setPlaceholder(color: UIColor, font: UIFont) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [
                .foregroundColor: color,
                .font: font
            ]
        )
    }
}

// MARK: - UIView

extension UIView{
    
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }

    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
}

// MARK: - UIApplication

extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release).\(build)"
    }
}
