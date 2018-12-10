//
//  BugReport_TextField.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/16.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class BugReport_TextField: UITextField {
    init(placeHolder: String,textSize: UIFont) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 2.5
        self.layer.borderColor = UIColor.grayColor_Normal.cgColor
        self.layer.cornerRadius = 5
        self.borderStyle = .roundedRect
        self.placeholder = placeHolder
        self.font = textSize
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
