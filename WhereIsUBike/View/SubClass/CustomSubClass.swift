//
//  CustomSubClass.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/16.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class CellLabel: UILabel {
    init(contents: String?,fontSize: UIFont,textColor: UIColor?) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = fontSize
        self.text = contents
        self.textColor = textColor

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CellStackView: UIStackView {
    init(with view1: UIView,with view2: UIView) {
        super.init(frame: CGRect.zero)
        self.addArrangedSubview(view1)
        self.addArrangedSubview(view2)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fillEqually
        self.axis = .vertical
        self.spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
