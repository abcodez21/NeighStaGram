//
//  Labels.swift
//  NeighStaGram
//
//  Created by Abdallahi Thiaw on 3/2/23.
//

import Foundation
import UIKit
class TitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {

        self.textAlignment = .center
        self.font = UIFont(name: N.Fonts.avenir_Medium, size: 40)
        self.textColor = UIColor.white
       
        
//        self.font = UIFont.boldSystemFont(ofSize: 60)
        self.adjustsFontSizeToFitWidth = true
    }

}


