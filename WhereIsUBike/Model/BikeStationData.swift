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
    var station_Distance_Number = 0.0
    var station_Latitude = ""
    var station_Longtitude = ""
    var station_Address = ""
    var userLocation_Latitude: Double = 0.0
    var userLocation_Longtitude: Double = 0.0
    
    init(station_Title: String,station_Borrow: String,station_Return: String,station_Distance: String,station_Distance_Number: Double,station_Latitude: String,station_Address: String,station_Longtitude: String,userLocation_Latitude: Double,userLocation_Longtitude: Double){
        self.station_Title = station_Title
        self.station_Borrow = station_Borrow
        self.station_Return = station_Borrow
        self.station_Distance = station_Distance
        self.station_Distance_Number = station_Distance_Number
        self.station_Latitude = station_Latitude
        self.station_Longtitude = station_Longtitude
        self.station_Address = station_Address
        self.userLocation_Latitude = userLocation_Latitude
        self.userLocation_Longtitude = userLocation_Longtitude
    }
}
