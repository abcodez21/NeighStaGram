import UIKit
import FirebaseAuth

class NSGLogInVC: UIViewController {
    let titleLabel = TitleLabel()
    let halfCircleImg = Edits.img(imgName: N.Img.curlyCirleImg)
    let curlyLineImg = Edits.img(imgName: N.Img.curlyLineImg)
    let childView = UIView()
    let loginBtn = CustomButton()
    let emailInput = Edits.textField(placeHolderText: "Email")
    let passwordInput = Edits.textField(placeHolderText: "Password")
    let forgotPasswordBtn = UIButton()
    let grandChildView = UIView()
    let newHereLabel = UILabel()
    let signUpBtn = UIButton()
    let errorLabel = Edits.errorLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        constrain()
        
    }
    
    @objc func loginBtnPr(){
        let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputs = [emailInput, passwordInput]
        
        if  Utilites.isInputNotEmpty(inputs: inputs){Auth.auth().signIn(withEmail: userEmail, password: userPassword) {
            (result, error) in
            
            if error != nil{
                
                Utilites.showError(errorLabel: self.errorLabel, message: error!.localizedDescription)
            }
            else{
                let homeVC = NSGHomeVC()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }
        }
        }
    }
    
    @objc func signUpBtnPr(){
        let signUpVC = NSGSignUpVC()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
        
    }
    
    @objc func forgotPasswordBtnPr(){
        let resetVC = NSGResetVC()
        resetVC.modalPresentationStyle = .fullScreen
        present(resetVC, animated: true, completion: nil)
    }
    
    
    private func configure(){
        view.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        childView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        grandChildView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        
        titleLabel.text = "Log In"
        loginBtn.setTitle("Log In", for: .normal)
        
        // applying icons & placeholders to each textfield input
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "person.circle", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: passwordInput, image: UIImage(systemName: "lock", withConfiguration: Edits.symbol())!)
        
        forgotPasswordBtn.setTitle("Forgot password?", for: .normal)
        forgotPasswordBtn.titleLabel?.font =  UIFont(name:  N.Fonts.avenir_light, size: 20)
        
        newHereLabel.text = "New Here?"
        newHereLabel.font = UIFont(name: N.Fonts.avenir_light, size: 20)
        newHereLabel.textColor = .white
        
        signUpBtn.titleLabel?.font = UIFont(name: N.Fonts.avenir_Heavy, size: 20)
        signUpBtn.setTitle("Sign Up", for: .normal)
        
        loginBtn.addTarget(self, action: #selector(loginBtnPr), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnPr), for: .touchUpInside)
        forgotPasswordBtn.addTarget(self, action: #selector(forgotPasswordBtnPr), for: .touchUpInside)
        
        passwordInput.isSecureTextEntry = true
        Edits.removeAuCorrect(textFields: [passwordInput, emailInput])
    }
    
    private func constrain(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(halfCircleImg)
        self.view.addSubview(curlyLineImg)
        self.view.addSubview(childView)
        
        childView.addSubview(emailInput)
        childView.addSubview(passwordInput)
        childView.addSubview(forgotPasswordBtn)
        childView.addSubview(loginBtn)
        childView.addSubview(grandChildView)
        childView.addSubview(errorLabel)
        
        
        grandChildView.addSubview(signUpBtn)
        grandChildView.addSubview(newHereLabel)
        
        halfCircleImg.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        curlyLineImg.translatesAutoresizingMaskIntoConstraints = false
        childView.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        grandChildView.translatesAutoresizingMaskIntoConstraints = false
        newHereLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 54).isActive = true
        titleLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: 90).isActive = true
        
        
        halfCircleImg.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -3).isActive = true
        halfCircleImg.topAnchor.constraint(equalTo:view.topAnchor, constant: 35).isActive = true
        halfCircleImg.heightAnchor.constraint(equalTo: halfCircleImg.heightAnchor).isActive = true
        halfCircleImg.widthAnchor.constraint(equalTo: halfCircleImg.widthAnchor).isActive = true
        
        curlyLineImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        curlyLineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 225.5).isActive = true
        curlyLineImg.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: 0).isActive = true
        curlyLineImg.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 0).isActive = true
        curlyLineImg.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 9.5).isActive = true
        
        // Child view contrains in view
        childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -92).isActive = true
        childView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        childView.heightAnchor.constraint(equalToConstant: 465).isActive = true
        childView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20.5).isActive = true
        childView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20.5).isActive = true
        
        loginBtn.topAnchor.constraint(equalTo: forgotPasswordBtn.bottomAnchor, constant: 21).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: 257).isActive = true
        loginBtn.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        
        emailInput.topAnchor.constraint(equalTo: childView.topAnchor, constant: 55).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
        
        
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 37).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        passwordInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        passwordInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
        
        forgotPasswordBtn.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 16).isActive = true
        forgotPasswordBtn.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        
        errorLabel.bottomAnchor.constraint(equalTo: emailInput.topAnchor, constant: -10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 345).isActive = true
        
        
        // Grandchild view contrains in view
        grandChildView.bottomAnchor.constraint(equalTo: childView.bottomAnchor, constant: 9.5).isActive = true
        grandChildView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        grandChildView.widthAnchor.constraint(equalToConstant: 262).isActive = true
        grandChildView.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        
        newHereLabel.leadingAnchor.constraint(equalTo: grandChildView.leadingAnchor, constant: 40).isActive = true
        newHereLabel.topAnchor.constraint(equalTo: grandChildView.topAnchor, constant: 16.5).isActive = true
        
        signUpBtn.leadingAnchor.constraint(equalTo: newHereLabel.trailingAnchor, constant: 3).isActive = true
        signUpBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        signUpBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        signUpBtn.topAnchor.constraint(equalTo: grandChildView.topAnchor, constant: 13.5).isActive = true
        
    }
}
