//
//  PostVC.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/10/23.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class NSGPostVC: UIViewController {

    let titleLabel = TitleLabel()
    let topView = UIView()
    let bottomView = UIView()
    let logoutBtn = UIButton()
    let homeBtn = UIButton()
    let homeLabel = UILabel()
    let postBtn = UIButton()
    let postLabel = UILabel()
    let errorLabel = Edits.errorLabel()
    let selectPicBtn = UIButton()
    let image = UIImageView()
    let postComment = Edits.textField(placeHolderText: "Add Comment", color: .white)
    
    let postSubmitBtn = UIButton()
    var username = "s"
    var profileImg = "a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constrain()
        
    }
    func configure(){
        view.backgroundColor = .white
        titleLabel.text = "NeighStaGram"
        titleLabel.font = UIFont(name: N.Fonts.avenir_Medium, size: 29)
        titleLabel.textColor = .white
        
        topView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        bottomView.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        
        logoutBtn.setTitle("Log out", for: .normal)
        logoutBtn.titleLabel?.font =  UIFont(name:  N.Fonts.avenir_light, size: 20)
        logoutBtn.setTitleColor(.tintColor, for: .normal)
        
        
        editBottomBtn(labelName: "Home", btn: homeBtn, imgName: "house", label: homeLabel)
        editBottomBtn(labelName: "Post", btn: postBtn, imgName: "plus.app", label: postLabel)
        
        postBtn.tintColor = .tintColor
        
        selectPicBtn.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        selectPicBtn.setTitle("Select Picture", for: .normal)
        selectPicBtn.titleLabel?.font =  UIFont(name:  N.Fonts.avenir_light, size: 23)
        selectPicBtn.layer.cornerRadius = 48 / 2
   
        

        
        postSubmitBtn.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        postSubmitBtn.setTitle("Post", for: .normal)
        postSubmitBtn.titleLabel?.font =  UIFont(name:  N.Fonts.avenir_Medium, size: 29)
        postSubmitBtn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        postSubmitBtn.semanticContentAttribute = .forceRightToLeft
        postSubmitBtn.layer.cornerRadius = 48 / 2
        postSubmitBtn.tintColor = .white
       
        
       
        
        Edits.setupLeftViewMode(input: postComment,image: UIImage(systemName: "bubble.right", withConfiguration: Edits.symbol())!)
        postComment.backgroundColor = UIColor(named: N.Colors.backgroundColor)
        postComment.textColor = .white
        postComment.layer.cornerRadius = 44 / 2
        
        image.contentMode = .scaleAspectFit
        
        getUsername()
        
        homeBtn.addTarget(self, action: #selector(homeBtnPr), for: .touchUpInside)
        selectPicBtn.addTarget(self, action: #selector(selectBtnPr), for: .touchUpInside)
        postSubmitBtn.addTarget(self, action: #selector(postSubmitBtnPr), for: .touchUpInside)
        logoutBtn.addTarget(self, action: #selector(logoutBtnPr), for: .touchUpInside)

    
    }
    @objc func logoutBtnPr(){
        let loginVC = NSGLogInVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func homeBtnPr(){
        let homeVC = NSGHomeVC()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    @objc func selectBtnPr(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:true)
        errorLabel.isHidden = true

    }
    
    @objc func postSubmitBtnPr(){
        let postCommentStr = postComment.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let path = "Image/\(UUID().uuidString).jpg"
        guard Utilites.isInputNotEmpty(inputs: [postComment]) == true else {
            return
        }
        guard image.image != nil else{
            errorLabel.isHidden = false
            errorLabel.text = "Select image"
            return
        }
        let storageRef = Storage.storage().reference()
        
        let imageData = image.image!.jpegData(compressionQuality: 0.8)
        
        guard imageData !=  nil else{
            return
        }
    
        let fileRef = storageRef.child(path)

        let uploadTask = fileRef.putData(imageData!) {
            metadata, error in
            if error == nil && metadata != nil{
                let db = Firestore.firestore()
                db.collection("Post").document().setData(["username": self.username, "postComment": postCommentStr, "ImgUrl": path, "Like": 0, "Dislike": 0, "profileImg": self.profileImg])
                self.homeBtnPr()
            }
        }
    }
   
    func constrain(){
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(selectPicBtn)
        view.addSubview(image)
        view.addSubview(postComment)
        view.addSubview(postSubmitBtn)
        view.addSubview(errorLabel)
        
        topView.addSubview(titleLabel)
        topView.addSubview(logoutBtn)
        
        bottomView.addSubview(homeBtn)
        bottomView.addSubview(homeLabel)
        bottomView.addSubview(postBtn)
        bottomView.addSubview(postLabel)


        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        homeBtn.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        postBtn.translatesAutoresizingMaskIntoConstraints = false
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        selectPicBtn.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        postComment.translatesAutoresizingMaskIntoConstraints = false
        postSubmitBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false


        
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        
        
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        
        
        
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 48).isActive = true
        
        logoutBtn.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 3).isActive = true
        logoutBtn.topAnchor.constraint(equalTo: topView.topAnchor, constant: 48).isActive = true
        
        homeBtn.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 7).isActive = true
        homeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        homeBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        homeBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 125).isActive = true
        
        homeLabel.topAnchor.constraint(equalTo: homeBtn.bottomAnchor, constant: 1).isActive = true
        homeLabel.centerXAnchor.constraint(equalTo: homeBtn.centerXAnchor).isActive = true
        
        
        postBtn.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 7).isActive = true
        postBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        postBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -125).isActive = true
        
        postLabel.topAnchor.constraint(equalTo: postBtn.bottomAnchor, constant: 1).isActive = true
        postLabel.centerXAnchor.constraint(equalTo: postBtn.centerXAnchor).isActive = true
        
        
        selectPicBtn.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 23).isActive = true
        selectPicBtn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        selectPicBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectPicBtn.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 321).isActive = true
        image.widthAnchor.constraint(equalToConstant: 297).isActive = true
        image.topAnchor.constraint(equalTo: selectPicBtn.bottomAnchor, constant: 23).isActive = true
        
        
        postComment.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 37).isActive = true
        postComment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postComment.widthAnchor.constraint(equalToConstant: 374).isActive = true
        postComment.heightAnchor.constraint(greaterThanOrEqualToConstant: 66).isActive = true
        
        
        postSubmitBtn.topAnchor.constraint(equalTo: postComment.bottomAnchor, constant: 43).isActive = true
        
        postSubmitBtn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        postSubmitBtn.widthAnchor.constraint(equalToConstant: 124).isActive = true
        postSubmitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    func editBottomBtn(labelName: String, btn: UIButton, imgName: String, label: UILabel){
        let modifySymbol = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)

        btn.setImage(UIImage(systemName: imgName, withConfiguration: modifySymbol), for: .normal)
        btn.tintColor = .white
        
        label.text = labelName
        label.font = UIFont(name: N.Fonts.avenir_Medium, size: 20)
        label.textColor = .white
    }
    
    func getUsername(){
        let db = Firestore.firestore()
        let userAccount = Auth.auth().currentUser?.email
        db.collection("users").document(userAccount!).getDocument { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    
                    DispatchQueue.main.async {
                        self.username = snapshot.get("username")! as! String
                        self.profileImg = snapshot.get("profileImg")! as! String
                        
                    }
                }
            }
            else{
                
            }
        }
        
        
    }
}


extension NSGPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let selectedImg = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            image.image = selectedImg
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
