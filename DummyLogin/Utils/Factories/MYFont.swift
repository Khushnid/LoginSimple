
import UIKit

public extension UIFont {
    static func appFont(size: CGFloat = 11, weight: String) -> UIFont {
        guard let font = UIFont(name: weight, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

}
