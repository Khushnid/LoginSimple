
import UIKit

protocol GenericViewProtocol {
    func setup()
    func setupSubviews()
    func setupConstraints()
    func setupTargets()
    func style()
    func localize()
}

extension GenericViewProtocol {
    func setup() {
        style()
        setupSubviews()
        setupConstraints()
        setupTargets()
        localize()
    }
}

class GenericView: UIView {
    
    var contentView = MYView()
    var contentViewBottom: NSLayoutConstraint!
    
       
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension GenericView: GenericViewProtocol {
    @objc func setupSubviews() {
        addSubview(contentView)
        
    }
    
    @objc func setupConstraints() {
        contentViewBottom = contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewBottom,
        ])
    }
    
    @objc func style() {
        backgroundColor = UIColor.white
    }
    
    @objc func localize() {
        
    }
    
    @objc func setupTargets() {
        
    }
}
