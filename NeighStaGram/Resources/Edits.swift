import Foundation
import UIKit


class Edits {
    
    // setup img
    static func img(imgName: String) -> UIImageView{
        let image = UIImage(named: imgName)
        let imageView = UIImageView(image: image!)
        
        return imageView
    }
    
    // setup placeholder text color
    static func textField(placeHolderText: String, color: UIColor = UIColor.gray) -> CustomTextField{
        let field = CustomTextField()

        field.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [NSAttributedString.Key.foregroundColor: color])
        
        return field
    }
    // remove auto correct
    static func removeAuCorrect(textFields: [UITextField]){
        for text in textFields{
            text.autocorrectionType = .no
            text.autocapitalizationType = .none
        }
    }
    // setup icon img
    static func setupLeftViewMode(input: CustomTextField ,image: UIImage) {
        input.leftViewMode = .always
        let leftView = UIImageView()
        leftView.tintColor = .black
        leftView.image = image
        leftView.contentMode = .scaleAspectFit
        input.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.centerYAnchor.constraint(equalTo: input.centerYAnchor).isActive = true
        leftView.leadingAnchor.constraint(equalTo: input.leadingAnchor, constant: 10).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: 40).isActive = true


    }
    
    // setup textfield icon weight
    static func symbol() -> UIImage.SymbolConfiguration{
        let modifyWeight = UIImage.SymbolConfiguration(weight: .ultraLight)
        return modifyWeight
    }
    
    static func returnSymbol() -> UIImage{
        let modifySymbol = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
        let image = UIImage(systemName: "lessthan", withConfiguration: modifySymbol)?.withTintColor(.white)
        
    
        return image!
    }
    
    static func errorLabel() -> UILabel {
        let errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.font = UIFont(name: N.Fonts.avenir_Medium, size: 17)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        return errorLabel
    }
    
}


class Utilites {
    static func isPasswordValid ( password : String, errorLabel: UILabel) -> Bool{
            let passwordTest = NSPredicate(format:
                                            "SELF MATCHES %@",
                                           "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        if !passwordTest.evaluate(with: password){
            
            Utilites.showError(errorLabel: errorLabel, message: "Please make sure your password atleast 8 characters contains 1 Alphabet and 1 Number.")
            return passwordTest.evaluate(with: password)
        }
        
            return passwordTest.evaluate(with: password)
        }
    
    static func isInputNotEmpty(inputs: [UITextField]) -> Bool{
            
            for input in inputs{
                if input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                    input.attributedPlaceholder = NSAttributedString(
                        string: "please fill in field",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

                    return false
                }
            }
            return true
        }
    
    static func showError(errorLabel: UILabel, message: String){
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    static func switchImg(image1: String, image2: String, current: String)-> String{
        if current == image1{
            return image2
        }else{
            return image1
        }
    }
}

