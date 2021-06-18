
import UIKit

class MYView: UIView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
