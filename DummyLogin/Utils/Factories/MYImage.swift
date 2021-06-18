
import UIKit

class MYImage: UIImageView {
    
    init(imageName: String? =  nil, cornerRadius: CGFloat = 0, contentMode: ContentMode = .scaleAspectFit) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: imageName!)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        self.contentMode = contentMode
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension UIImage {
    func blurredImage(with context: CIContext, radius: CGFloat, atRect: CGRect) -> UIImage? {
        guard let ciImg = CIImage(image: self) else { return nil }
        
        let cropedCiImg = ciImg.cropped(to: atRect)
        let blur = CIFilter(name: "CIGaussianBlur")
        blur?.setValue(cropedCiImg, forKey: kCIInputImageKey)
        blur?.setValue(radius, forKey: kCIInputRadiusKey)
        
        if let ciImgWithBlurredRect = blur?.outputImage?.composited(over: ciImg),
           let outputImg = context.createCGImage(ciImgWithBlurredRect, from: ciImgWithBlurredRect.extent) {
            return UIImage(cgImage: outputImg)
        }
        return nil
    }
}
