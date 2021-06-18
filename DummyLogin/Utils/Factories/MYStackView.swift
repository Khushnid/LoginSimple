
import UIKit

class MYStackView : UIStackView {
    
    init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution,  alignment: UIStackView.Alignment, spacing: CGFloat = 8.0) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

