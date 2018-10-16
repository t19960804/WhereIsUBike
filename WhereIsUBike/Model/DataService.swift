//
//  ViewController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/14.
//  Copyright © 2018 t19960804. All rights reserved.
//
//["category_id":4017,"filter":[["filter_id":"214","value_ids":"6433"]],"type":"2"]  lng eq 121.428348
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    let basicURL = "http://data.ntpc.gov.tw/od/data/api/54DDDC93-589C-4858-9C95-18B2046CC1FC?"
    
    let parameters = ["$format" : "json"]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        getJSON()
    }

    func getJSON(){
        //reponseString -> responseJSON
        Alamofire.request(basicURL,method: .get,parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                // convert data to dictionary array
                
                let ubikeJSON = JSON(response.result.value!)
                print(ubikeJSON)
                
                self.decodeJSON(with: ubikeJSON)
            }else{
                print("error: \(response.error)")
            }
        }
    }
    func decodeJSON(with json: JSON){
            let testString = json.arrayValue.filter { (getJSON) -> Bool in
                return (getJSON["lat"].stringValue == "24.99116" && getJSON["lng"].stringValue == "121.53398")
            }
        print("count:\(testString.count)")
        
        }
    
    
}

