//
//  ListStationTests.swift
//  WhereIsUBikeTests
//
//  Created by t19960804 on 2018/11/11.
//  Copyright © 2018 t19960804. All rights reserved.
//

import XCTest
import MapKit
@testable import WhereIsUBike
class ListStationTests: XCTestCase {
    
    var listStationDetailController: ListStationController_Detail!
    var model: BikeModel!
    var viewModel: BikeViewModel!
    override func setUp() {
        super.setUp()
        
        listStationDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListStationDetail") as! ListStationController_Detail
        //let _ = listStationDetailController.view
        let userLocation = CLLocation()
        
        model = BikeModel(station_Title: "捷運新莊站(1號出口)", station_Borrow: "1", station_Return: "2", station_Latitude: "25.036152", station_Address: "中正路/中華路一段", station_Longtitude: "121.452069", userLocation: userLocation)
        viewModel = BikeViewModel(bikeModel: model)
        listStationDetailController.bikeViewModel = viewModel
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testVariableAndComponent(){
        XCTAssertEqual(listStationDetailController.apiKey,
                       "AIzaSyBFiJuxMRnRrP-0aAptDNdesmtrSVGpLGY")
        XCTAssertEqual(listStationDetailController.address_Label.text, viewModel.station_Address)
        XCTAssertEqual(listStationDetailController.distance_Label.text, viewModel.station_Distance)
        
    }
   
}
