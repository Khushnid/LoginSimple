
import UIKit
import GoogleSignIn
import FBSDKCoreKit
import KakaoSDKUser

class LoginScreenController: GenericController {
    
    let _view = LoginScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleClicks()
        setup()
    }
    
    override func loadView() {
        view = _view
    }
}

extension LoginScreenController {
    
    private func setup() {
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        _view.birthField.delegate = self
    }
    
    private func setupKokoa() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                self._view.nameField.text = user?.kakaoAccount?.profile?.nickname ?? ""
                self._view.surnameField.text =  user?.kakaoAccount?.profile?.nickname ?? ""
                self._view.emailField.text = user?.kakaoAccount?.email ?? ""
                self._view.phoneField.text = ""
                self._view.birthField.text = ""
                
                _ = user
            }
        }
    }
    
    private func handleClicks() {
        _view.signUpHandler = {
            self.validate()
        }
        
        _view.googleHandler = {
            GIDSignIn.sharedInstance().signIn()
            self._view.facebookButton.isEnabled = false
            self._view.kokoaButton.isEnabled = false
            self._view.googleButton.isEnabled = false
        }
        
        _view.facebookHandler = { [weak self] in
            guard let self = self else { return }
            self.showAlert(for: "Feature be available soon")
        }
        
        _view.kokoaHandler = {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    self.showAlert(for: error.localizedDescription)
                }
                else {
                    self.showAlert(for: "Logged in with Kokoa")
                    self.setupKokoa()
                }

                self._view.facebookButton.isEnabled = false
                self._view.kokoaButton.isEnabled = false
                self._view.googleButton.isEnabled = false
            }
        }
    }
    
    func validate() {
        do {
            let name = try self._view.nameField.validatedText(validationType: ValidatorType.name(field: "Name"))
            let surname = try self._view.surnameField.validatedText(validationType: ValidatorType.name(field: "Surname"))
            let email = try _view.emailField.validatedText(validationType: ValidatorType.email)
            let phone = try _view.phoneField.validatedText(validationType: ValidatorType.phoneNumber)
            let date = try self._view.birthField.validatedText(validationType: .requiredField(field: "Date"))
            let data = RegisterData(name: name, surname: surname, email: email, birthDate: date, phoneNumber: phone)
            save(data)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func save(_ data: RegisterData) {
        
        GIDSignIn.sharedInstance().signOut()
        
        UserPreferences.shared.userName = data.name
        UserPreferences.shared.userPhone = data.phoneNumber
        
        // MARK:  that's funny, I know. Static tokens...
        UserPreferences.shared.userToken = data.name + data.phoneNumber
        
        navigationController?.pushViewController(HomeScreenController(), animated: true)
        showAlert(for: "Registered Successfully")
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LoginScreenController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == _view.birthField {
            _view.showDatePicker()
        }
        return true
    }
}

extension LoginScreenController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            _view.nameField.text = user.profile.givenName
            _view.surnameField.text = user.profile.familyName
            _view.emailField.text = user.profile.email
            _view.phoneField.text = ""
            _view.birthField.text = ""
        } else {
            showAlert(for: error.localizedDescription)
        }
    }
}
