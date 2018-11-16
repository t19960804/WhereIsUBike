//
//  BugReport_Label.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/14.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit
class BugReport_Label: UILabel{
    
    init(content: String){
        //在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.text = "\(content)"
        self.font = self.font.withSize(20)
        self.textColor = UIColor.grayColor_Normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
