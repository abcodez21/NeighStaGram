//
//  button.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/5/23.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.backgroundColor = UIColor(named: N.Colors.btnColor)
        self.layer.cornerRadius = 57 / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.titleLabel?.font =  UIFont(name: "Avenir-light", size: 30)
    }
}
