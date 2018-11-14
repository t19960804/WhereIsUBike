//
//  InformStackView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/14.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit
class InformStackView: UIStackView {
    
    init(with view1: UIView,with view2: UIView) {
        super.init(frame: CGRect.zero)
        self.addArrangedSubview(view1)
        self.addArrangedSubview(view2)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
