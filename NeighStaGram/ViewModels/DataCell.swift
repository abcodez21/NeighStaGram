//
//  TableViewCell.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/8/23.
//

import UIKit
import FirebaseFirestore
class DataCell: UITableViewCell {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var postImg: UIImageView!
    @IBOutlet var postCommentLabel: UILabel!
    
    
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var dislikeBtn: UIButton!
    
    
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var dislikeLabel: UILabel!
    var id = ""
    var like = true
    var dislike = true
    var likeAmount = 0
    var dislikeAmount = 0
    var difference = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        likeLabel.text = String(likeAmount)
        dislikeLabel.text = String(dislikeAmount)
    }
    

    @IBAction func likeBtnPR(_ sender: UIButton) {
       
        if like{
            likeBtn.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            dislikeBtn.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
            difference = 1
            
            like = false
        }else{
            likeBtn.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            difference = 0
            likeLabel.text = String(likeAmount)
            like = true
        }
        change()
    }
    
    @IBAction func dislikeBtnPR(_ sender: UIButton) {
        
        if dislike{
            dislikeBtn.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            likeBtn.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            difference = -1
            dislike = false
        }else{
            dislikeBtn.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
            difference = 0
            dislikeLabel.text = String(dislikeAmount)
            dislike = true
        }
        change()
    }
    
    func change(){
        let db = Firestore.firestore()
        
        if difference == 1{
            
           likeLabel.text = String(likeAmount + 1)
            dislikeLabel.text = String(dislikeAmount)


        } else if difference == -1{
            dislikeLabel.text = String(dislikeAmount + 1)
            likeLabel.text = String(likeAmount)

            
        }
        db.collection("Post").document(id).setData(["Like": Int(likeLabel.text!)!, "Dislike": Int(dislikeLabel.text!)!], merge: true)
        
    }
    
}
