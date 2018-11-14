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
    var interNetSerVice = InterNetService()
    var userLocation = CLLocation()
    var bikeViewModelArray = [BikeViewModel]()
    @IBOutlet weak var userMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userMapSetting()
        locationManagerSetting()
        fetchData()
        addAnnotation()
    }
    func fetchData(){
        interNetSerVice.dealWithJSON(userLocation: self.userLocation, completion: { (modelArray) in
            
            //將Model包裝成ViewModel
            self.bikeViewModelArray = modelArray.map({ (bikeItem) -> BikeViewModel in
                return BikeViewModel(bikeModel: bikeItem)
            })
            //依照距離排序
            self.bikeViewModelArray.sort{ (item1, item2) -> Bool in
                return item1.stationDistance_Number < item2.stationDistance_Number
            }
            let navigaationController_Second = self.tabBarController?.viewControllers![1] as! UINavigationController
            let listStationController = navigaationController_Second.viewControllers[0] as! ListStationController
           //傳給下一頁
            listStationController.bikeViewModelArray = self.bikeViewModelArray
        }, controller: self)
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

    func addAnnotation(){
        bikeViewModelArray.forEach { (viewModelItems) in
            //加入大頭針
            annotationSetting(lattitude: Double(viewModelItems.station_Lat) ?? 0.0, longtitude: Double(viewModelItems.station_Lng) ?? 0.0,stationName: viewModelItems.station_Title,canBorrow: viewModelItems.station_Borrow,canReturn: viewModelItems.station_Return,map: userMap)
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
        fetchData()
        addAnnotation()
        
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
        if stationTitle! == "My Location"{
            
            annotationView?.image = UIImage(named: "location64")
        
        }else{
            
            annotationView?.image = UIImage(named: "bike64")
        }
        
        annotationView?.canShowCallout = true
        return annotationView
    }
    
}
