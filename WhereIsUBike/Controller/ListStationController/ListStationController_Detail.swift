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
    var bikeStationData: BikeStationData?
    let testKey = "AIzaSyChY6vLVBYllLenYveKqvuNnbU8pb5G__4"
    let apiKey = "AIzaSyBFiJuxMRnRrP-0aAptDNdesmtrSVGpLGY"
    let interNetService = InterNetService()
    let googleMapView: GMSMapView = {
        let view = GMSMapView()
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let seperateLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
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
    let address_ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "map")

        return imageView
    }()
    lazy var address_StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [address_ImageView,address_Label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    /////////////
    let distance_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20.0)

        return label
    }()
    let distance_ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "route")
        return imageView
    }()
    lazy var distance_StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distance_ImageView,distance_Label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapView.delegate = self
        guard let bikeStationData = bikeStationData else{return}
        self.navigationItem.title = bikeStationData.station_Title
        //使用者位置
        let user_Latitude = bikeStationData.userLocation_Latitude
        let user_Longtitude = bikeStationData.userLocation_Longtitude
        //站點位置
        let station_Latitude = bikeStationData.station_Latitude
        let station_Longtitude = bikeStationData.station_Longtitude
        //站點位置
        let station_Address = bikeStationData.station_Address
        //距離
        let distance = bikeStationData.station_Distance
        addSubView()
        setUpConstraints()
        
        address_Label.text = "\(station_Address)"
        distance_Label.text = "\(distance)"
        showGoogleMap(lat: user_Latitude, lng: user_Longtitude)
        createMarker_Begin(lat: user_Latitude, lng: user_Longtitude)
        createMarker_End(lat: Double(station_Latitude)!, lng: Double(station_Longtitude)!)
        let parameters_Direction = ["key" : self.apiKey,
                                     "mode" : "walking",
                                     "alternatives" : "true",
                                     "origin" : "\(user_Latitude),\(user_Longtitude)",
                                     "destination" : "\(Double(station_Latitude)!),\(Double(station_Longtitude)!)"]
        interNetService.dealWithJSON_Direction(parameters_Direction: parameters_Direction) { (json) in
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
        self.view.addSubview(googleMapView)
        self.view.addSubview(seperateLine)
        self.view.addSubview(bottomView)
        bottomView.addSubview(address_StackView)
        bottomView.addSubview(distance_StackView)
    }
    func setUpConstraints(){
        googleMapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        googleMapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        googleMapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
        googleMapView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7).isActive = true
        googleMapView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        /////////////////
        seperateLine.topAnchor.constraint(equalTo: googleMapView.bottomAnchor).isActive = true
        seperateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperateLine.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        /////////////////
        
        /////////////////
        bottomView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        bottomView.topAnchor.constraint(equalTo: seperateLine.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        /////////////////
        address_StackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 7).isActive = true
        address_StackView.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 10).isActive = true
        address_StackView.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -10).isActive = true
        address_StackView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.6).isActive = true
        address_StackView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.9).isActive = true
        
        address_ImageView.bottomAnchor.constraint(equalTo: address_StackView.bottomAnchor, constant: 0).isActive = true

        address_ImageView.widthAnchor.constraint(equalTo: address_StackView.widthAnchor, multiplier: 0.1).isActive = true
        address_ImageView.heightAnchor.constraint(equalTo: address_StackView.heightAnchor, multiplier: 0.3).isActive = true

        address_Label.rightAnchor.constraint(equalTo: address_StackView.rightAnchor, constant: -20).isActive = true
        address_Label.heightAnchor.constraint(equalTo: address_StackView.heightAnchor,multiplier: 0.38).isActive = true
        address_Label.widthAnchor.constraint(equalTo: address_StackView.widthAnchor,multiplier: 0.85).isActive = true

        ////////////
        distance_StackView.leftAnchor.constraint(equalTo: bottomView.leftAnchor,constant: 10).isActive = true
        distance_StackView.topAnchor.constraint(equalTo: address_StackView.bottomAnchor,constant: 15).isActive = true
////        distance_StackView.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor,constant: -10).isActive = true
        distance_StackView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.4).isActive = true
        distance_StackView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.9).isActive = true
        //////
        distance_ImageView.topAnchor.constraint(equalTo: distance_StackView.topAnchor,constant: 0).isActive = true

        distance_ImageView.widthAnchor.constraint(equalTo: distance_StackView.widthAnchor, multiplier: 0.1).isActive = true
        distance_ImageView.heightAnchor.constraint(equalTo: distance_StackView.heightAnchor, multiplier: 0.4).isActive = true
        //////
        distance_Label.topAnchor.constraint(equalTo: distance_StackView.topAnchor, constant: 0).isActive = true

        distance_Label.heightAnchor.constraint(equalTo: distance_StackView.heightAnchor,multiplier: 0.5).isActive = true
        distance_Label.widthAnchor.constraint(equalTo: distance_StackView.widthAnchor,multiplier: 0.85).isActive = true

        

        
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
