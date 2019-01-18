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


class InterNetService {
    let basicURL = "http://data.ntpc.gov.tw/od/data/api/54DDDC93-589C-4858-9C95-18B2046CC1FC?"
    let directionURL = "https://maps.googleapis.com/maps/api/directions/json"
    let parameters = ["$format" : "json"]
    var modelArray = [BikeModel]()
    var userLocation = CLLocation()
    
    static let sharedInstance = InterNetService()
    
    func dealWithJSON(userLocation: CLLocation,completion:@escaping ([BikeModel]) -> Void,controller: UIViewController)  {
        //reponseString -> responseJSON
        //只有responseJSON可以用平常的方法解
        //因為Alamofire是非同步,所以執行途中會到其他地方,我這邊等他執行結束後使用completion handler
        Alamofire.request(basicURL,method: .get,parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                
                let ubikeJSON = JSON(response.result.value!)
                
                if self.modelArray.isEmpty{
                    //包裝成Model(陣列)
                    let bikeModel = self.wrapToModel(userLocation: userLocation, with: ubikeJSON)
                    completion(bikeModel)
                }else{
                    self.modelArray.removeAll()
                    //包裝成Model(陣列)
                    let bikeModel = self.wrapToModel(userLocation: userLocation,with: ubikeJSON)
                    completion(bikeModel)
                }
                
                
            }else{
                let errorCode = (response.error! as NSError).code
                if errorCode == -1009{
                    self.showAlert(message: "請檢查網路", with: controller)
                }else{
                    self.showAlert(message: "目前無法取得資料", with: controller)
                    print("code:",errorCode)
                }
            }
            
        }
        
        
    }
    
    func showAlert(message: String, with controller: UIViewController){
        let alert = Alert(message: message, title: "出現錯誤", with: controller )
        alert.alert_InterNet()
    }
    func wrapToModel(userLocation: CLLocation,with json: JSON) -> [BikeModel]{
        //解析JSON並建立物件
        self.modelArray = json.arrayValue.map{BikeModel(json: $0, userLocation: userLocation)}
        return modelArray
    }
}

