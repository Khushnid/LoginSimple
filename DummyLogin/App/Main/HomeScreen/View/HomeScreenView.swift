
import UIKit

class HomeScreenView : GenericView {
    let header = MYLabel(textColor: .black, textAlignment: .left, numberOfLines: 1)
    let userName = MYLabel(textColor: .black, textAlignment: .left, numberOfLines: 1)
    let backView = MYImage(imageName: "backHome", contentMode: .scaleAspectFill)
    let logoutButton = MYButton(title: "Log out", size: .lg17)
    
    var logoutHandler: (() -> Void)?
}

extension HomeScreenView {
    
    override func setupTargets() {
        super.setupTargets()
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .primaryActionTriggered)
    }
    
    @objc func logoutAction() {
        logoutHandler?()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(backView)
        contentView.addSubview(header)
        contentView.addSubview(userName)
        contentView.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            userName.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 4),
            userName.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            logoutButton.centerYAnchor.constraint(equalTo: header.centerYAnchor),
        ])
    }
    
    override func style() {
        super.style()
        
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.setTitleColor(.gray, for: .selected)
        
        header.font = UIFont.systemFont(ofSize: .lg28, weight: .semibold)
        userName.font = UIFont.systemFont(ofSize: .lg21, weight: .regular)
    }
    
    override func localize() {
        super.localize()
        header.text = "Home Page"
        userName.text = UserPreferences.shared.userName
    }
}

