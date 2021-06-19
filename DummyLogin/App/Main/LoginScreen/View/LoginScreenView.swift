
import UIKit
import FBSDKLoginKit


class LoginScreenView : GenericScrollView {
    let stackView = MYStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 32)
    let buttonsStack = MYStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 12)
    
    let title = MYLabel(textColor: .black, textAlignment: .left, insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    let getInfoWith = MYLabel(textColor: UIColor(hex: "#778899FF")!, textAlignment: .center, insets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), numberOfLines: 0)
    
    let nameField = MYTextField(textColor: .black, cursorColor: .black, borderColor: .clear)
    let surnameField = MYTextField(textColor: .black, cursorColor: .black, borderColor: .clear)
    let emailField = MYTextField(textColor: .black, cursorColor: .black, borderColor: .clear)
    let birthField = MYTextField(textColor: .black, cursorColor: .black, borderColor: .clear)
    let phoneField = MYTextField(textColor: .black, cursorColor: .black, borderColor: .clear)
    
    let signupButton = MYButton(title: "SIGN UP", cornerRadius: 8, backgroundColor: UIColor(hex: "#1C8ADBFF")!)
    let googleButton = MYButton()
    let facebookButton = MYButton()
    let kokoaButton = MYButton()
   
    var signUpHandler: (() -> Void)?
    var googleHandler: (() -> Void)?
    var facebookHandler: (() -> Void)?
    var kokoaHandler: (() -> Void)?
    
    let datePicker = UIDatePicker()
}

extension LoginScreenView {
    
    override func setupTargets() {
        super.setupTargets()
        setupStackView()
        
        signupButton.addTarget(self, action: #selector(signUpAction), for: .primaryActionTriggered)
        googleButton.addTarget(self, action: #selector(googleAction), for: .primaryActionTriggered)
        facebookButton.addTarget(self, action: #selector(facebookAction), for: .primaryActionTriggered)
        kokoaButton.addTarget(self, action: #selector(appleAction), for: .primaryActionTriggered)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        scrollContent.addSubview(stackView)
        scrollContent.addSubview(signupButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: signupButton.topAnchor, constant: -24),
            
            signupButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            signupButton.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -32),
        ])
    }
    
    override func style() {
        super.style()
        
        customizeTextFields()
        customizeLoginButtons()
        
        title.font = UIFont.systemFont(ofSize: FontSize.lg28, weight: .bold)
        getInfoWith.font = UIFont.systemFont(ofSize: FontSize.sm12, weight: .regular)
    }
    
    private func customizeLoginButtons() {
        
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.lg17, weight: .semibold)
        signupButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        googleButton.withImage(imageName: "google")
        facebookButton.withImage(imageName: "facebook")
        kokoaButton.withImage(imageName: "apple")
        
        googleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        facebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        kokoaButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        googleButton.makeSize()
        googleButton.backgroundColor = .clear
        googleButton.layer.cornerRadius = 16
        googleButton.layer.borderWidth = 0.8
        googleButton.layer.borderColor = UIColor(hex: "#778899FF")!.cgColor
        
        facebookButton.makeSize()
        facebookButton.backgroundColor = .clear
        facebookButton.layer.cornerRadius = 16
        facebookButton.layer.borderWidth = 0.8
        facebookButton.layer.borderColor = UIColor(hex: "#778899FF")!.cgColor
        
        kokoaButton.makeSize()
        kokoaButton.backgroundColor = .clear
        kokoaButton.layer.cornerRadius = 16
        kokoaButton.layer.borderWidth = 0.8
        kokoaButton.layer.borderColor = UIColor(hex: "#778899FF")!.cgColor
    }
    
    private func customizeTextFields() {
        nameField.addPlaceHolder(fieldText: "Name", color: UIColor(hex: "#778899FF")!)
        nameField.addLeftImage(imageName: "person")
        nameField.changeKeyboardTo(.alphabet)
        nameField.addBottomBorder()
        
        surnameField.addPlaceHolder(fieldText: "Surname", color: UIColor(hex: "#778899FF")!)
        surnameField.addLeftImage(imageName: "person")
        surnameField.changeKeyboardTo(.alphabet)
        surnameField.addBottomBorder()
        
        emailField.addPlaceHolder(fieldText: "Email ID", color: UIColor(hex: "#778899FF")!)
        emailField.addLeftImage(imageName: "mailSign")
        emailField.changeKeyboardTo(.emailAddress)
        emailField.addBottomBorder()
        
        phoneField.addPlaceHolder(fieldText: "Phone Number", color: UIColor(hex: "#778899FF")!)
        phoneField.addLeftImage(imageName: "phone")
        phoneField.changeKeyboardTo(.phonePad)
        phoneField.addBottomBorder()
        
        birthField.addPlaceHolder(fieldText: "Date of birth", color: UIColor(hex: "#778899FF")!)
        birthField.addLeftImage(imageName: "dob")
        birthField.changeKeyboardTo(.emailAddress)
        birthField.addBottomBorder()
    }
    
    override func localize() {
        super.localize()
        title.text = "Sign up"
        getInfoWith.text = "Or, get info using:"
    }
    
    private func setupStackView() {
        buttonsStack.addArrangedSubview(googleButton)
        buttonsStack.addArrangedSubview(facebookButton)
        buttonsStack.addArrangedSubview(kokoaButton)
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(surnameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(phoneField)
        stackView.addArrangedSubview(birthField)
        stackView.addArrangedSubview(getInfoWith)
        stackView.addArrangedSubview(buttonsStack)
    
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Choose", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        birthField.inputAccessoryView = toolbar
        birthField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthField.text = formatter.string(from: datePicker.date)
        self.birthField.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.birthField.endEditing(true)
    }
    
    @objc func signUpAction() { signUpHandler?() }
    @objc func googleAction() { googleHandler?() }
    @objc func facebookAction() { facebookHandler?() }
    @objc func appleAction() { kokoaHandler?() }
}

