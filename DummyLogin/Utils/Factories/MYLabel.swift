
import UIKit

class MYLabel: UILabel {
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 7.0
    var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    convenience init(fontSize: CGFloat = 11, fontWeight: String = "", textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), numberOfLines: Int = 0) {
        
        self.init()
        
        topInset = insets.top
        leftInset = insets.left
        rightInset = insets.right
        bottomInset = insets.bottom
        
        isHidden = false
        
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        
        font = .appFont(size: fontSize, weight: fontWeight)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        self.textColor = textColor
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        text = "MY_LABEL"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}
