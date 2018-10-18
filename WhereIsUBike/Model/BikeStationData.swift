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
    var bike_Borrow = ""
    var bike_Return = ""
    
    init(station_Title: String,bike_Borrow: String,bike_Return: String){
        self.station_Title = station_Title
        self.bike_Borrow = bike_Borrow
        self.bike_Return = bike_Return
    }
}
