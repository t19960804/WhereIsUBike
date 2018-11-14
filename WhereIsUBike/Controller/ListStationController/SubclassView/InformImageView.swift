//
//  ImageView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/14.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit
class InformImageView: UIImageView{
    var imageName: String
    init(imageName: String){
        self.imageName = imageName
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: "\(imageName)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
