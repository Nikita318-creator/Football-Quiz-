import UIKit

extension String {
    var capitalizedFirst: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
