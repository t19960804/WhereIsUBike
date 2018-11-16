//
//  SearchBar.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class SearchBar: UISearchBar {
    init(placeHolder: String,tintColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "\(placeHolder)"
        self.barTintColor = tintColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
