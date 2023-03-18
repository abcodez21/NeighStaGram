//
//  ResetVC.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/2/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ResetVC: UIViewController {
    let titleLabel = TitleLabel()
    let halfCircleImg = Edits.img(imgName: N.Img.curlyCirleImg)
    let curlyLineImg = Edits.img(imgName: N.Img.curlyLineImg)
    let childView = UIView()
    let emailInput = Edits.textField(placeHolderText: "Email")
    let errorLabel = Edits.errorLabel()
    let backBtn = UIButton()
    let resetBtn = CustomButton()


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
    @objc func resetBtnPr(){
       let inputs = [emailInput]
        let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilites.isInputNotEmpty(inputs: inputs){
            let auth = Auth.auth()
            
            auth.sendPasswordReset(withEmail: userEmail){(error) in
                if error != nil{
                    Utilites.showError(errorLabel: self.errorLabel, message: error!.localizedDescription)
                }
                else{
                    Utilites.showError(errorLabel: self.errorLabel, message: "A new passowrd rest email has been sent!")
                    self.errorLabel.textColor = .green

                }
            }
        }
        
    }

    func configure(){
        view.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        childView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        
        Edits.removeAuCorrect(textFields: [emailInput])
        titleLabel.text = "Reset Password"
        titleLabel.font = UIFont(name: N.Fonts.avenir_Medium, size: 27)
        
        resetBtn.setTitle("Reset", for: .normal)
        
        backBtn.setImage(Edits.returnSymbol(), for: .normal)
        backBtn.tintColor = .white
        
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "envelope", withConfiguration: Edits.symbol())!)
        
        backBtn.addTarget(self, action: #selector(backBtnPr), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetBtnPr), for: .touchUpInside)
    }
    
    func constrain(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(halfCircleImg)
        self.view.addSubview(curlyLineImg)
        self.view.addSubview(childView)
        self.view.addSubview(backBtn)
        self.view.addSubview(errorLabel)
        
        childView.addSubview(emailInput)
        childView.addSubview(resetBtn)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        halfCircleImg.translatesAutoresizingMaskIntoConstraints = false
        curlyLineImg.translatesAutoresizingMaskIntoConstraints = false
        childView.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 36).isActive = true
        titleLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: 110).isActive = true
        
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
        childView.topAnchor.constraint(equalTo: halfCircleImg.bottomAnchor, constant: 160).isActive = true
        childView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        childView.heightAnchor.constraint(equalToConstant: 164).isActive = true
        childView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20.5).isActive = true
        childView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20.5).isActive = true
        
        emailInput.topAnchor.constraint(equalTo: childView.topAnchor, constant: 0).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 57).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:childView.trailingAnchor, constant: 0).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:childView.leadingAnchor, constant: 0).isActive = true
        
        resetBtn.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 50).isActive = true
        resetBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        resetBtn.widthAnchor.constraint(equalToConstant: 257).isActive = true
        resetBtn.centerXAnchor.constraint(equalTo: childView.centerXAnchor).isActive = true
        
        
        errorLabel.bottomAnchor.constraint(equalTo: emailInput.topAnchor, constant: -20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 345).isActive = true
        
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
    }
    
}
