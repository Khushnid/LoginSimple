
import UIKit

public class MYTextField: UITextField {
    var padding: UIEdgeInsets
    
    public init(padding: UIEdgeInsets = .zero, backgroundColor: UIColor = .clear, textColor: UIColor = .black, cursorColor: UIColor = .black, borderColor: UIColor = .clear, withImage: Bool = true) {
        self.padding = padding
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .default
        autocorrectionType = .no
        layer.borderColor = borderColor.cgColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        tintColor = cursorColor
        
        if withImage {
            self.padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addPlaceHolder(fieldText: String = "MYTextField", color: UIColor = UIColor.gray.withAlphaComponent(0.7)) {
        attributedPlaceholder = NSAttributedString(string: fieldText, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func changeKeyboardTo(_ keyboardType: UIKeyboardType = .default) {
        self.keyboardType = keyboardType
    }
    
    func addLeftImage(imageName: String) {
        leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: imageName)
        imageView.image = image
        leftView = imageView
    }
    
    internal func addBottomBorder(height: CGFloat = 1.0, color: UIColor = UIColor(hex: "#778899FF")!) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            borderView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    // MARK:  paddings
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
