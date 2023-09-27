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
    
        //multiple corners using CACornerMask
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
