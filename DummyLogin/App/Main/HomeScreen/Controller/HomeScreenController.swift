
import UIKit

class HomeScreenController: GenericController {
    
    let _view = HomeScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTargets()
    }
    
    override func loadView() {
        view = _view
    }
}

extension HomeScreenController {
    private func setup() {
     
    }
    
    private func setupTargets() {
        _view.logoutHandler = {
            
            UserPreferences.shared.userToken = nil
            UserPreferences.shared.userName = nil
            UserPreferences.shared.userPhone = nil
            
            restartApplication()
           
        }
    }
}

