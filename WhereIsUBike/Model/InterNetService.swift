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
    let parameters = ["$format" : "json"]
    var stationArray = [BikeStationData]()
    
    
    func dealWithJSON(completion:@escaping (JSON) -> Void)  {
        //reponseString -> responseJSON
        //只有responseJSON可以用平常的方法解
        //因為Alamofire是非同步,所以執行途中會到其他地方,我這邊等他執行結束後使用completion handler
        Alamofire.request(basicURL,method: .get,parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                
                let ubikeJSON = JSON(response.result.value!)
                completion(ubikeJSON)
                print(ubikeJSON)
            }else{print("error: \(response.error)")}

        }


    }

}
