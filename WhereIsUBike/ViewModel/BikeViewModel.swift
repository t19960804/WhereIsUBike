//
//  BikeViewModel.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/11/8.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import MapKit
struct BikeViewModel {
    var userLocation = CLLocation()
    
    var station_Title: String
    var station_Lat: String
    var station_Lng: String
    var station_Borrow: String
    var station_Return: String
    var station_Address: String
    var station_Distance: String = ""
    var stationDistance_Number: Double = 0.0
    
    //將Model裡的"純"資料做邏輯運算,初始化ViewModel的屬性
    init(bikeModel: BikeModel) {
        self.station_Title = bikeModel.station_Title
        self.station_Lat = bikeModel.station_Latitude
        self.station_Lng = bikeModel.station_Longtitude
        self.station_Borrow = bikeModel.station_Borrow
        self.station_Return = bikeModel.station_Return
        self.userLocation = bikeModel.userLocation
        self.station_Address = bikeModel.station_Address
        self.station_Distance = calculateDistance(station_lat: bikeModel.station_Latitude, station_lng: bikeModel.station_Longtitude).distance_String
        self.stationDistance_Number = calculateDistance(station_lat: bikeModel.station_Latitude, station_lng: bikeModel.station_Longtitude).distance_Number
        
    }
    //邏輯運算
    func calculateDistance(station_lat: String,station_lng: String) -> (distance_String: String,distance_Number: Double){
        //計算兩點距離
        var distance = Double(userLocation.distance(from: CLLocation(latitude: Double(station_lat) ?? 0.0 , longitude: Double(station_lng) ?? 0.0 )))

        //某些距離會多出一大段距離
        if  distance >= 13150000{
            distance -= 13150000
            return ("\(String(format:"%.1f",distance / 1000))公里",distance)
        }else if distance >= 11610000{
            distance -= 11610000

            return  ("\(String(format:"%.1f",distance / 1000))公里",distance)
        }else if distance >= 1000{

            return  ("\(String(format:"%.1f",distance / 1000))公里",distance)
        }else{
            return  ("\(String(format:"%.1f",distance))公尺",distance)
        }
    }
}
