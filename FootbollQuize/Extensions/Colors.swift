import UIKit

extension UIColor {
    static let primary = UIColor(hex: "#0A234F")
    static let success = UIColor(hex: "#196B11")
    static let error = UIColor(hex: "#CD3939")
    static let textColor = UIColor(hex: "#010814")
    static let secondTextColor = UIColor(hex: "#4B686D")
    static let activeColor = UIColor(hex: "#B7DE16")
    static let backgroundMain = UIColor(hex: "#E7EAF0")
        
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            // Возвращаем серый цвет, если формат неверный
            self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: alpha)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
