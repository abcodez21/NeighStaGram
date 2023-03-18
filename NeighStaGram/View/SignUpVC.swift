//
//  SignUpVC.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/2/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    let titleLabel = TitleLabel()
    let halfCircleImg = Edits.img(imgName: N.Img.curlyCirleImg)
    let curlyLineImg = Edits.img(imgName: N.Img.curlyLineImg)
    let childView = UIView()
    let usernameInput = Edits.textField(placeHolderText: "Username")
    let emailInput = Edits.textField(placeHolderText: "Email")
    let passwordInput = Edits.textField(placeHolderText: "Password")
    let signUpBtn = CustomButton()
    let errorLabel = Edits.errorLabel()
    let backBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constrain()

        
    }
    @objc func backBtnPr(){
        let loginVC = LogInVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
        
    }
    @objc func signUpBtnPr(){
        let userPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputs = [usernameInput, emailInput, passwordInput]
        
        
        
        if Utilites.isInputNotEmpty(inputs: inputs) && Utilites.isPasswordValid(password: userPassword, errorLabel: errorLabel){
            
            let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userUsername = usernameInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            let profileImg = containsOnlyLetters(profileImgString: String(userUsername.prefix(1)))
            
            // create user
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) {(result, error) in
                
                if error != nil{
                    Utilites.showError(errorLabel: self.errorLabel, message: error!.localizedDescription)
                }
                else{
                    let db = Firestore.firestore()
                    let userAccount = Auth.auth().currentUser?.email
                    db.collection("users").document(userAccount!).setData(["username": userUsername, "profileImg": profileImg]){
                        (error) in
                        if error != nil {
                            Utilites.showError(errorLabel: self.errorLabel, message: "Error saving user data")
                        }
                    }
                    let homeVC = HomeVC()
                    homeVC.modalPresentationStyle = .fullScreen
                    self.present(homeVC, animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    

    func configure(){
        view.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        childView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        
        titleLabel.text = "Sign Up"
        signUpBtn.setTitle("Sign Up", for: .normal)
        
        Edits.setupLeftViewMode(input: usernameInput, image: UIImage(systemName: "person.circle", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: passwordInput, image: UIImage(systemName: "lock", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "envelope", withConfiguration: Edits.symbol())!)
        
       
    
        backBtn.setImage(Edits.returnSymbol(), for: .normal)
        backBtn.tintColor = .white
        
        backBtn.addTarget(self, action: #selector(backBtnPr), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnPr), for: .touchUpInside)
        
        passwordInput.isSecureTextEntry = true
        Edits.removeAuCorrect(textFields: [usernameInput, passwordInput, emailInput])

        
    }
    func constrain(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(halfCircleImg)
        self.view.addSubview(curlyLineImg)
        self.view.addSubview(childView)
        self.view.addSubview(backBtn)
        
        childView.addSubview(usernameInput)
        childView.addSubview(passwordInput)
        childView.addSubview(emailInput)
        childView.addSubview(signUpBtn)
        childView.addSubview(errorLabel)

        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        halfCircleImg.translatesAutoresizingMaskIntoConstraints = false
        curlyLineImg.translatesAutoresizingMaskIntoConstraints = false
        childView.translatesAutoresizingMaskIntoConstraints = false
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false

        
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
        
        errorLabel.bottomAnchor.constraint(equalTo: usernameInput.topAnchor, constant: -10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 345).isActive = true
        
        
        usernameInput.topAnchor.constraint(equalTo: childView.topAnchor, constant: 55).isActive = true
        usernameInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        usernameInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        usernameInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
        
        emailInput.topAnchor.constraint(equalTo: usernameInput.bottomAnchor, constant: 57).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
        
        
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 57).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        passwordInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        passwordInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
       
        signUpBtn.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 47).isActive = true
        signUpBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        signUpBtn.widthAnchor.constraint(equalToConstant: 257).isActive = true
        signUpBtn.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
    }
    
    func containsOnlyLetters(profileImgString: String) -> String {
       for chr in profileImgString {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
              return "profile/\(profileImgString.uppercased()).png"
          }
       }
        return "profile/\(profileImgString).png"
    }
}
