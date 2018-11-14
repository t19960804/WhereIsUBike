//
//  ListStationController_Detail.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/23.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
class ListStationController_Detail: UIViewController,GMSMapViewDelegate {
    
    var bikeViewModel: BikeViewModel?{
        didSet{
            self.navigationItem.title = bikeViewModel!.station_Title
            address_Label.text = bikeViewModel?.station_Address
            distance_Label.text = bikeViewModel?.station_Distance
            //使用者位置
            let user_Latitude = bikeViewModel!.userLocation.coordinate.latitude
            let user_Longtitude = bikeViewModel!.userLocation.coordinate.longitude
            //站點位置
            let station_Latitude = bikeViewModel!.station_Lat
            let station_Longtitude = bikeViewModel!.station_Lng
            
            
            self.dataSetting(user_lat: user_Latitude, user_long: user_Longtitude, station_lat: station_Latitude, station_long: station_Longtitude)
        }
    }
    let testKey = "AIzaSyChY6vLVBYllLenYveKqvuNnbU8pb5G__4"
    let apiKey = "AIzaSyBFiJuxMRnRrP-0aAptDNdesmtrSVGpLGY"
    let interNetService = InterNetService()

    let mainBackGroundView = BackGroundView(color: nil)
    let bottomView = BackGroundView(color: nil)
    let top_BottomView = BackGroundView(color: nil)
    let seperateLine = BackGroundView(color: nil)
    let bottom_BottomView = BackGroundView(color: nil)
    let address_ImageView = InformImageView(imageName: "map")
    let distance_ImageView = InformImageView(imageName: "route")
    lazy var address_StackView = InformStackView(with: address_ImageView, with: address_Label)
    lazy var distance_StackView = InformStackView(with: distance_ImageView, with: distance_Label)
    
    
    
    let googleMapView: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let address_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let distance_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setUpConstraints()
        googleMapView.delegate = self

    }
    fileprivate func dataSetting(user_lat user_Latitude: Double,user_long user_Longtitude: Double,station_lat station_Latitude: String,station_long station_Longtitude: String){
        
        showGoogleMap(lat: user_Latitude, lng: user_Longtitude)
        createMarker_Begin(lat: user_Latitude, lng: user_Longtitude)
        createMarker_End(lat: Double(station_Latitude)!, lng: Double(station_Longtitude)!)
        let parameters_Direction = ["key" : self.apiKey,
                                    "mode" : "walking",
                                    "alternatives" : "true",
                                    "origin" : "\(user_Latitude),\(user_Longtitude)",
            "destination" : "\(Double(station_Latitude)!),\(Double(station_Longtitude)!)"]
        interNetService.dealWithJSON_Direction(with: parameters_Direction) { (json) in
            self.drawTheDirection(with: json)
        }
    }
    func showGoogleMap(lat: Double,lng: Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15.0)
        googleMapView.camera = camera
    }
    //Google地圖的大頭針叫做 Marker
    func createMarker_Begin(lat: Double,lng: Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        //這個 map 屬性一開始是沒有值。如果是沒有值的話，大頭針不會秀出來
        marker.map = googleMapView
        
    }
    func createMarker_End(lat: Double,lng: Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        //這個 map 屬性一開始是沒有值。如果是沒有值的話，大頭針不會秀出來
        marker.map = googleMapView
        marker.icon = UIImage(named: "bike64")
        
    }
    func addSubView(){
        self.view.addSubview(mainBackGroundView)
        mainBackGroundView.addSubview(googleMapView)
        mainBackGroundView.addSubview(bottomView)
        //
        bottomView.addSubview(top_BottomView)
        bottomView.addSubview(seperateLine)
        bottomView.addSubview(bottom_BottomView)
        //
        top_BottomView.addSubview(address_StackView)

        bottom_BottomView.addSubview(distance_StackView)
    }
    func setUpConstraints(){
        let safeAreaHeight_Top = UIApplication.shared.keyWindow!.safeAreaInsets.top
        let safeAreaHeight_Bottom = UIApplication.shared.keyWindow!.safeAreaInsets.bottom

        mainBackGroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeAreaHeight_Top + 44).isActive = true
        mainBackGroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mainBackGroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        mainBackGroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(safeAreaHeight_Bottom + 49)).isActive = true
        mainBackGroundView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        ///////////////////////////////////////////////////////////////
        googleMapView.topAnchor.constraint(equalTo: mainBackGroundView.topAnchor).isActive = true
        googleMapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        googleMapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        googleMapView.heightAnchor.constraint(equalTo: mainBackGroundView.heightAnchor, multiplier: 0.8).isActive = true
        googleMapView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        ///////////////////////////////////////////////////////////////

        bottomView.heightAnchor.constraint(equalTo: mainBackGroundView.heightAnchor, multiplier: 0.2).isActive = true
        bottomView.topAnchor.constraint(equalTo: googleMapView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: mainBackGroundView.bottomAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        ///////////////////////////////////////////////////////////////

        top_BottomView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        top_BottomView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        top_BottomView.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        top_BottomView.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        ///////////////////////////////////////////////////////////////

        bottom_BottomView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        bottom_BottomView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        bottom_BottomView.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        bottom_BottomView.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true


        /////////////////
        address_StackView.topAnchor.constraint(equalTo: top_BottomView.topAnchor).isActive = true
        address_StackView.leftAnchor.constraint(equalTo: top_BottomView.leftAnchor).isActive = true
        address_StackView.rightAnchor.constraint(equalTo: top_BottomView.rightAnchor).isActive = true
        address_StackView.heightAnchor.constraint(equalTo: top_BottomView.heightAnchor, multiplier: 1).isActive = true
        address_StackView.widthAnchor.constraint(equalTo: top_BottomView.widthAnchor, multiplier: 1).isActive = true
        
        address_ImageView.centerYAnchor.constraint(equalTo: top_BottomView.centerYAnchor).isActive = true
        address_ImageView.widthAnchor.constraint(equalTo: top_BottomView.widthAnchor, multiplier: 0.1).isActive = true
        address_ImageView.heightAnchor.constraint(equalTo: top_BottomView.heightAnchor, multiplier: 0.6).isActive = true
        address_ImageView.leftAnchor.constraint(equalTo: top_BottomView.leftAnchor, constant: 5).isActive = true

        address_Label.centerYAnchor.constraint(equalTo: top_BottomView.centerYAnchor).isActive = true
        address_Label.rightAnchor.constraint(equalTo: top_BottomView.rightAnchor, constant: -8).isActive = true

        address_Label.heightAnchor.constraint(equalTo: top_BottomView.heightAnchor,multiplier: 0.9).isActive = true
        address_Label.widthAnchor.constraint(equalTo: top_BottomView.widthAnchor,multiplier: 0.85).isActive = true

        seperateLine.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        seperateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperateLine.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true


        //////////////////////////////////////////
        distance_StackView.leftAnchor.constraint(equalTo: bottom_BottomView.leftAnchor).isActive = true
        distance_StackView.rightAnchor.constraint(equalTo: bottom_BottomView.rightAnchor).isActive = true
        distance_StackView.bottomAnchor.constraint(equalTo: bottom_BottomView.bottomAnchor).isActive = true
        distance_StackView.heightAnchor.constraint(equalTo: bottom_BottomView.heightAnchor, multiplier: 1).isActive = true
        distance_StackView.widthAnchor.constraint(equalTo: bottom_BottomView.widthAnchor, multiplier: 1).isActive = true

        distance_ImageView.centerYAnchor.constraint(equalTo: bottom_BottomView.centerYAnchor).isActive = true
        distance_ImageView.widthAnchor.constraint(equalTo: bottom_BottomView.widthAnchor, multiplier: 0.1).isActive = true
        distance_ImageView.heightAnchor.constraint(equalTo: bottom_BottomView.heightAnchor, multiplier: 0.6).isActive = true
        distance_ImageView.leftAnchor.constraint(equalTo: bottom_BottomView.leftAnchor, constant: 5).isActive = true

        //////
        distance_Label.centerYAnchor.constraint(equalTo: bottom_BottomView.centerYAnchor).isActive = true
        distance_Label.rightAnchor.constraint(equalTo: bottom_BottomView.rightAnchor, constant: -8).isActive = true

        distance_Label.heightAnchor.constraint(equalTo: bottom_BottomView.heightAnchor,multiplier: 0.9).isActive = true
        distance_Label.widthAnchor.constraint(equalTo: bottom_BottomView.widthAnchor,multiplier: 0.85).isActive = true

        

        
    }
    func drawTheDirection(with json: JSON){
        let steps_Array = json["routes"][0]["legs"][0]["steps"].arrayValue
        for item in steps_Array{
            let points = item["polyline"]["points"].stringValue
            let path = GMSPath.init(fromEncodedPath: points)
            let polyline = GMSPolyline.init(path: path)
            polyline.strokeWidth = 4
            polyline.strokeColor = UIColor.red
            polyline.map = self.googleMapView
            
        }
    }
    

}
