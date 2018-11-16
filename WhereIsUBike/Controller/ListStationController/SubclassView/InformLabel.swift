//
//  InformLabel.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit
class InformLabel: UILabel {
    init(fontSize: UIFont,numberOfLines: Int) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = fontSize
        self.numberOfLines = numberOfLines
        self.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
