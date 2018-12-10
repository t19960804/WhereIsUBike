//
//  BugReport_TextView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/16.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class BugReportTextView: UITextView {
    init(textSize: UIFont) {
       super.init(frame: CGRect.zero, textContainer: NSTextContainer?.none)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = textSize
        //以下無法改變字型大小
        //textView.font = textView.font?.withSize(18)
        self.layer.borderWidth = 2.5
        self.layer.borderColor = UIColor.grayColor_Normal.cgColor
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
