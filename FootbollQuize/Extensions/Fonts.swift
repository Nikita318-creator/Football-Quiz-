import UIKit

import UIKit

// Расширение для удобного доступа к кастомным шрифтам
extension UIFont {
    
    // MARK: - Основной шрифт
    
    /**
     Возвращает основной шрифт (например, MainFont-Regular) заданного размера.
     Используйте: label.font = .main(size: 16)
     */
    static func main(size: CGFloat) -> UIFont {
        // Замените "MainFont-Regular" на фактическое PostScript-имя вашего шрифта
        return UIFont(name: "MainFont-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    // MARK: - Дополнительный шрифт
    
    /**
     Возвращает дополнительный шрифт (например, SecondFont-Bold) заданного размера.
     Используйте: label.font = .second(size: 20)
     */
    static func second(size: CGFloat) -> UIFont {
        // Замените "SecondFont-Bold" на фактическое PostScript-имя вашего второго шрифта
        return UIFont(name: "SecondFont-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
