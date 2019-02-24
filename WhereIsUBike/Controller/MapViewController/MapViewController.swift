//
//  MapViewController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/15.
//  Copyright © 2018 t19960804. All rights reserved.
//
//中港經緯: 25.054916 / 121.450905
//幸福經緯: 25.049627 / 121.459427
import UIKit
import MapKit
import SwiftyJSON
import SVProgressHUD

class MapViewController: UIViewController {
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    @IBOutlet weak var userMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userMapSetting()
        locationManagerSetting()
        fetchDataAndSetAnnotation()
    }
    
    func fetchDataAndSetAnnotation(){
        InterNetService.sharedInstance.dealWithJSON(userLocation: self.userLocation, completion: { (modelArray) in
            self.addAnnotations(with: modelArray)
        }, controller: self)
    }
    fileprivate func passLocation(){
        let navigaationController_Second = self.tabBarController?.viewControllers![1] as! UINavigationController
        let listStationController = navigaationController_Second.viewControllers[0] as! ListStationController
        listStationController.userLocation = self.userLocation
    }
    fileprivate func userMapSetting(){
        userMap.delegate = self
        // 顯示自身定位位置
        userMap.showsUserLocation = true
        // 允許縮放地圖
        userMap.isZoomEnabled = true
    }
    fileprivate func locationManagerSetting(){
        //請求使用者授權
        locationManager.requestWhenInUseAuthorization()
        
        //使用者同意
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    //加入大頭針
    func addAnnotations(with array: [BikeModel]){
        array.forEach {
            annotationSetting(lattitude: Double($0.station_Latitude) ?? 0.0,
                              longtitude: Double($0.station_Longtitude) ?? 0.0,
                              stationName: $0.station_Title,
                              canBorrow: $0.station_Borrow,
                              canReturn: $0.station_Return,
                              map: userMap)
            
        }
    }
    
    func annotationSetting(lattitude: Double,longtitude: Double,stationName: String,canBorrow: String,canReturn: String,map: MKMapView){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lattitude , longitude: longtitude)
        annotation.title = stationName
        annotation.subtitle = "可借:\(canBorrow)    可還:\(canReturn)"
        map.addAnnotation(annotation)
    }
    

}
//使用者移動後
//觸發以下的fetchData()
//fetchData()裡面將包裝好的ViewModel陣列給ListStationController
extension MapViewController: CLLocationManagerDelegate{
    //顯示特定區域 -> 座標 + 縮放範圍
    //當使用者座標改變後觸發
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newestLocation = locations.last else {return}
        userLocation = newestLocation
        //放大比例(latitudeDelta/longitudeDelta)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta:0.003 )
        let mapRegion = MKCoordinateRegion.init(center: userLocation.coordinate, span: mapSpan)

        userMap.setRegion(mapRegion, animated: true)
        passLocation()
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        //因為annotationView可能是nil
        guard let stationTitle = annotation.title else{return nil}
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        annotationView?.image = stationTitle == "My Location" ? UIImage(named: "location64") : UIImage(named: "bike64")
        annotationView?.canShowCallout = true
        return annotationView
    }
    
}

