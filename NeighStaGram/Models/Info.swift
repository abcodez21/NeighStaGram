import Foundation
import UIKit

struct Post: Identifiable{
    let id: String
    let ImgUrl: String
    let postComment: String
    let username: String
    let Like: Int
    let Dislike: Int
    let profileImg: String
}
