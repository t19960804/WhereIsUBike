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
        //super.init() 必须放在本类属性初始化的后面，保证本类属性全部初始化完成
        //自身屬性要先有值,才能呼叫super.init()
        //如果屬性只有 "宣告類別" 但是沒有 "賦值",賦值的時候要在super.init()之前
        //要使用self之前必須先呼叫super.init()
        
        //這裡能放後面是因為這些繼承來的屬性都有 "初始值"
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
