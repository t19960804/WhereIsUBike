//
//  BikeStationData.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation

struct BikeStationData {
    var station_Title = ""
    var station_Borrow = ""
    var station_Return = ""
    var station_Distance = ""
    var station_Distance_Number = 0
    init(station_Title: String,station_Borrow: String,station_Return: String,station_Distance: String,station_Distance_Number: Int){
        self.station_Title = station_Title
        self.station_Borrow = station_Borrow
        self.station_Return = station_Borrow
        self.station_Distance = station_Distance
        self.station_Distance_Number = station_Distance_Number
    }
}
