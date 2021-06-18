
import UIKit

class GenericController: UIViewController {
    
    let mainView = GenericView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupObservers()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension GenericController {
    
    func pushToController(_ controller : UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
  
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let mainView = view as? GenericView {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.2) {
                    let height: CGFloat = (self.tabBarController?.tabBar.isHidden ?? true) ? 0 : self.tabBarController?.tabBar.frame.height ?? 0
                    mainView.contentViewBottom.constant = -(keyboardSize.height - height)
                    mainView.setNeedsUpdateConstraints()
                    mainView.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let mainView = view as? GenericView {
            UIView.animate(withDuration: 0.2) {
                mainView.contentViewBottom.constant = 0
                mainView.setNeedsUpdateConstraints()
                mainView.layoutIfNeeded()
            }
        }
    }
    
    func setupObservers() {
        if let mainView = view as? GenericView {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            
            mainView.addGestureRecognizer(tap)
        }
    }
}
