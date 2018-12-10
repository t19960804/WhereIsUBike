//
//  ListStationTableView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit

class StationTableView: UITableView {
    init(reuseIdentifier: String) {
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(BikeListCell.self, forCellReuseIdentifier: reuseIdentifier)
        //隱藏滾動條
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
