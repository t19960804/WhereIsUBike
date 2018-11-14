//
//  InternetTest.swift
//  WhereIsUBikeTests
//
//  Created by t19960804 on 2018/11/10.
//  Copyright © 2018 t19960804. All rights reserved.
//

import XCTest
import Alamofire
@testable import WhereIsUBike
class InternetTest: XCTestCase {
    let interNetService = InterNetService()
    let basicURL = "http://data.ntpc.gov.tw/od/data/api/54DDDC93-589C-4858-9C95-18B2046CC1FC?"
    let directionURL = "https://maps.googleapis.com/maps/api/directions/json"
    let parameters = ["$format" : "json"]
    let apiKey = "AIzaSyBFiJuxMRnRrP-0aAptDNdesmtrSVGpLGY"

    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    func testVariable(){
        XCTAssertEqual(interNetService.basicURL, basicURL)
        XCTAssertEqual(interNetService.directionURL, directionURL)
    }
    func testDealWithJSON(){
        //一個expectation都要對應一個fullfill()
        let successExpectation = expectation(description: "Connect Success")
        Alamofire.request(basicURL,method: .get,parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                XCTAssertNotNil(response)
                successExpectation.fulfill()
                
            }else{
                let errorCode = (response.error! as NSError).code
                if errorCode == -1009{
                    XCTFail("Internet Unavailable")
                }else{
                    XCTFail("Error!")
                }
            }
            
        }
        //超時或是所有的expectation被fullfill時觸發
        waitForExpectations(timeout: 5) { (error) in
            print("error:\(error)")
        }
    }
    func testDealWithJSON_Direction(){
        let parameters_Direction = ["key" : self.apiKey,
                                    "mode" : "walking",
                                    "alternatives" : "true",
                                    "origin" : "25.054916,121.450905",
                                    "destination" : "25.054232,121.451752"]
        //一個expectation都要對應一個fullfill()
        let successExpectation = expectation(description: "Connect Success")
        Alamofire.request(directionURL,method: .get,parameters: parameters_Direction).responseJSON { response in
            if response.result.isSuccess {
                XCTAssertNotNil(response)
                successExpectation.fulfill()
                
            }else{
                let errorCode = (response.error! as NSError).code
                if errorCode == -1009{
                    XCTFail("Internet Unavailable")
                }else{
                    XCTFail("Error!")
                }
            }
            
        }
        //超時或是所有的expectation被fullfill時觸發
        waitForExpectations(timeout: 5) { (error) in
            print("error:\(error)")
        }
    }
   

}
