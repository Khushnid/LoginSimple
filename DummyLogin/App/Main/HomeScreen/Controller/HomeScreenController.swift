
import UIKit
import GoogleSignIn
import KakaoSDKUser

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
            
            // MARK:  signing out from SDK(google, fb, kokoa)
            GIDSignIn.sharedInstance().signOut()
            
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")
                }
            }
            
            UserPreferences.shared.userToken = nil
            UserPreferences.shared.userName = nil
            UserPreferences.shared.userPhone = nil
            
            restartApplication()
           
        }
    }
}

