//
//  HomeVC.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/7/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
class NSGHomeVC: UIViewController {
    let titleLabel = TitleLabel()
    let topView = UIView()
    let bottomView = UIView()
    let logoutBtn = UIButton()
    let homeBtn = UIButton()
    let homeLabel = UILabel()
    let postBtn = UIButton()
    let postLabel = UILabel()
    let dataView = UITableView()
    
    var stats: [Post] = []
// HomeIdentifier
    override func viewDidLoad() {
        super.viewDidLoad()
        dataView.dataSource = self
        loadData()
        configure()
        constrain()
        
        
    }
    func configure(){
        view.backgroundColor = .white
        
        dataView.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "HomeIdentifier")
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
        
        
        logoutBtn.addTarget(self, action: #selector(logoutBtnPr), for: .touchUpInside)
        postBtn.addTarget(self, action: #selector(postBtnPr), for: .touchUpInside)
        
        homeBtn.tintColor = .tintColor

    
    }
    
    @objc func logoutBtnPr(){
        let loginVC = NSGLogInVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func postBtnPr(){
        let postVC = NSGPostVC()
        postVC.modalPresentationStyle = .fullScreen
        present(postVC, animated: true, completion: nil)
        
    }
    func constrain(){
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(dataView)
        
        topView.addSubview(titleLabel)
        topView.addSubview(logoutBtn)
        
        bottomView.addSubview(homeBtn)
        bottomView.addSubview(homeLabel)
        bottomView.addSubview(postBtn)
        bottomView.addSubview(postLabel)


        dataView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        homeBtn.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        postBtn.translatesAutoresizingMaskIntoConstraints = false
        postLabel.translatesAutoresizingMaskIntoConstraints = false

        dataView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        dataView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        dataView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        dataView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true

        
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


    }
    
    func editBottomBtn(labelName: String, btn: UIButton, imgName: String, label: UILabel){
        let modifySymbol = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)

        btn.setImage(UIImage(systemName: imgName, withConfiguration: modifySymbol), for: .normal)
        btn.tintColor = .white
        
        label.text = labelName
        label.font = UIFont(name: N.Fonts.avenir_Medium, size: 20)
        label.textColor = .white
    }
    
    func loadData(){
        let db = Firestore.firestore()
        db.collection("Post").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    for doc in snapshot.documents{
                        self.stats.append(
                            Post(id: doc.documentID, ImgUrl: doc["ImgUrl"] as? String ?? "",
                                 postComment:  doc["postComment"] as? String ?? "",
                                 username: doc["username"] as? String ?? "",
                                 Like: doc["Like"] as? Int ?? 0, Dislike: doc["Dislike"] as? Int ?? 0,
                                 profileImg: doc["profileImg"] as? String ?? ""))
                        
                    }
                    DispatchQueue.main.async {self.dataView.reloadData()}
                }
            }
            else{
                
            }
        }
        
    }

}

extension NSGHomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeIdentifier", for: indexPath) as! DataCell
        cell.postCommentLabel.text = self.stats[indexPath.row].postComment
        cell.usernameLabel.text = self.stats[indexPath.row].username
        cell.id = self.stats[indexPath.row].id
        cell.dislikeAmount = self.stats[indexPath.row].Dislike
        cell.likeAmount = self.stats[indexPath.row].Like
        // upload img
        let path = stats[indexPath.row].ImgUrl
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(path)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil{
                let image = UIImage(data: data!)
                cell.postImg.image = image
            }
        }
        
        // upload profile
        let path2 = stats[indexPath.row].profileImg
        let storageRef2 = Storage.storage().reference()
        let fileRef2 = storageRef2.child(path2)
        fileRef2.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil{
                let image = UIImage(data: data!)
                cell.profileImg.image = image
            }
        }

        return cell
    }
    
    
    
}


