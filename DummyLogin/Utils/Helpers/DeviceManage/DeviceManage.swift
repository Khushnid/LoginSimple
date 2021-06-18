
import UIKit

public var isIPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

public var isIPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

func restartApplication () {
    let viewController = LoginScreenController()
    let navCtrl = UINavigationController(rootViewController: viewController)
    
    guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else { return }
    
    navCtrl.view.frame = rootViewController.view.frame
    navCtrl.navigationBar.isHidden = true
    navCtrl.view.layoutIfNeeded()
    
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
        window.rootViewController = navCtrl
    })
    
}
