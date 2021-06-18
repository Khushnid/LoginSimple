
import UIKit

class GenericScrollView: GenericView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let scrollContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension GenericScrollView {
    private func setup() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(scrollContent)
        
        let containerHeight = scrollContent.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        containerHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            scrollContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerHeight,
        ])
    }
}
