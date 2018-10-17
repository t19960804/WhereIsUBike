//
//  InterNetService.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/16.
//  Copyright © 2018 t19960804. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit


struct InterNetService {
    let basicURL = "http://data.ntpc.gov.tw/od/data/api/54DDDC93-589C-4858-9C95-18B2046CC1FC?"
    let parameters = ["$format" : "json"]
    
    func dealWithJSON(map: MKMapView) {
        //reponseString -> responseJSON
        //只有responseJSON可以用平常的方法解
        Alamofire.request(basicURL,method: .get,parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                // convert data to dictionary array
                
                let ubikeJSON = JSON(response.result.value!)
                for jsonObject in ubikeJSON.arrayValue{
                    let lat = jsonObject["lat"].stringValue
                    let lng = jsonObject["lng"].stringValue
                    let staion = jsonObject["sna"].stringValue
                    let number_Borrow = jsonObject["sbi"].stringValue
                    let number_Return = jsonObject["bemp"].stringValue

                    self.addAnnotations(lattitude: Double(lat) ?? 0.0, longtitude: Double(lng) ?? 0.0, map: map,stationName: staion,canBorrow: number_Borrow,canReturn: number_Return)
                }

                //self.decodeJSON(with: ubikeJSON)
            }else{print("error: \(response.error)")}

        }
    }

    func addAnnotations(lattitude: Double,longtitude: Double,map: MKMapView,stationName: String,canBorrow: String,canReturn: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lattitude , longitude: longtitude)
        annotation.title = stationName
        annotation.subtitle = "可借:\(canBorrow)    可還:\(canReturn)"
        map.addAnnotation(annotation)
    }
}
