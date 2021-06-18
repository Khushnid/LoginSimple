
import UIKit

class MYButton: UIButton {
    
    init(title: String? = nil, size: CGFloat = 11, weight: String? = nil, cornerRadius: CGFloat = 0.0, backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.appFont(size: size, weight: weight ?? "")
        setTitle(title, for: .normal)
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
    
    func withImage(imageName: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        setImage(UIImage(named: imageName), for: .normal)
        imageView?.contentMode = contentMode
    }
    
    func shadow(color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.25
    }
    
    func contentInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func imageInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeSize(width: CGFloat = 48, height: CGFloat = 48) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        heightAnchor.constraint(equalToConstant: width).isActive = true
    }
}
