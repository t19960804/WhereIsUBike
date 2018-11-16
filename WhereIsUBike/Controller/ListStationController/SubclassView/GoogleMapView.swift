//
//  GoogleMapView.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class GoogleMapView: GMSMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
