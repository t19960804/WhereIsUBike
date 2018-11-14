//
//  BackGroundView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/14.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class BackGroundView: UIView {
    var color: UIColor?
    init(color: UIColor?) {
        self.color = color
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
