//
//  BikeStationData.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import MapKit
import SwiftyJSON
struct BikeModel {
    var station_Title = ""
    var station_Borrow = ""
    var station_Return = ""
    var station_Latitude = ""
    var station_Longtitude = ""
    var station_Address = ""
    var userLocation = CLLocation()
    
    init(json: JSON,userLocation: CLLocation) {
        //參數說明 -> 車站名 / 可借還數量 / 距離當前位置距離(字串) / 距離當前位置距離(整數) / 車站經緯度 / 使用者當前經緯度

        self.station_Title = json["sna"].stringValue
        self.station_Borrow = json["sbi"].stringValue
        self.station_Return = json["bemp"].stringValue
        self.station_Latitude = json["lat"].stringValue
        self.station_Longtitude = json["lng"].stringValue
        self.station_Address = json["ar"].stringValue
        self.userLocation = userLocation
        
        
    }
}
