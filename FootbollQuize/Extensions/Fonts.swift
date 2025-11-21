import UIKit

extension UIFont {
    
    static func main(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "UNCAGE-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func second(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Onest-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
}
