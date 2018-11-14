//
//  BikeStationData.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import MapKit
struct BikeModel {
    var station_Title = ""
    var station_Borrow = ""
    var station_Return = ""
    var station_Latitude = ""
    var station_Longtitude = ""
    var station_Address = ""
    var userLocation = CLLocation()
    
    
    init(station_Title: String,station_Borrow: String,station_Return: String,station_Latitude: String,station_Address: String,station_Longtitude: String,userLocation: CLLocation){
        self.station_Title = station_Title
        self.station_Borrow = station_Borrow
        self.station_Return = station_Borrow
        self.station_Latitude = station_Latitude
        self.station_Longtitude = station_Longtitude
        self.station_Address = station_Address
        self.userLocation = userLocation
       
    }
}
