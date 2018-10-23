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
class MapViewController: UIViewController {
    var locationManager = CLLocationManager()
    var interNetSerVice = InterNetService()
    var userLocation = CLLocation()
    var bikeStationArray = [BikeStationData]()
    var distanceOfStation = ""
    @IBOutlet weak var userMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userMap.delegate = self
        // 顯示自身定位位置
        userMap.showsUserLocation = true
        // 允許縮放地圖
        userMap.isZoomEnabled = true
        //請求使用者授權
        locationManager.requestWhenInUseAuthorization()

        //使用者同意
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
        
        interNetSerVice.dealWithJSON { (json) in
            self.analyzeJSON(with: json)
            
            guard let destination = self.tabBarController?.viewControllers![1] as? ListStationController else{
                return
            }
            destination.bikeStationArray = self.bikeStationArray
        }
    }
    
    func analyzeJSON(with json: JSON) {
        //viewDidLoad跟地點變動時各觸發一次,清空避免累加
        //地點變動後切換頁面再觸發
        if bikeStationArray.isEmpty == false{
            bikeStationArray.removeAll()
            sortItemsAndAddAnnotation(with: json)
        }else{
            sortItemsAndAddAnnotation(with: json)
        }
        
    }
    func sortItemsAndAddAnnotation(with json: JSON){
        for jsonObject in json.arrayValue{
            let lat = jsonObject["lat"].stringValue
            let lng = jsonObject["lng"].stringValue
            let name = jsonObject["sna"].stringValue
            let number_Borrow = jsonObject["sbi"].stringValue
            let number_Return = jsonObject["bemp"].stringValue
            //計算兩點距離
            var distance = userLocation.distance(from: CLLocation(latitude: Double(lat) ?? 0.0, longitude: Double(lng) ?? 0.0))
            //某些距離會多出一大段距離
            if Int(distance) >= 13150000{
                distance = distance - 13150000
                distanceOfStation = "\(String(format:"%.1f",distance / 1000))公里"
                
            }else if Int(distance) >= 11610000{
                distance = distance - 11610000
                distanceOfStation = "\(String(format:"%.1f",distance / 1000))公里"
            }
            else if Int(distance) >= 1000{
                distanceOfStation = "\(String(format:"%.1f",distance / 1000))公里"

            }else{
                distanceOfStation = "\(Int(distance))公尺"
            }
            let station_Object = BikeStationData(station_Title: name, station_Borrow: number_Borrow, station_Return: number_Return,station_Distance: distanceOfStation,station_Distance_Number: Int(distance))
            bikeStationArray.append(station_Object)
            addAnnotations(lattitude: Double(lat) ?? 0.0, longtitude: Double(lng) ?? 0.0,stationName: name,canBorrow: number_Borrow,canReturn: number_Return,map: userMap)
            
        }
        //依照距離排序
        bikeStationArray.sort{ (stationData1, stationData2) -> Bool in
            return stationData1.station_Distance_Number < stationData2.station_Distance_Number
        }
    }
    func addAnnotations(lattitude: Double,longtitude: Double,stationName: String,canBorrow: String,canReturn: String,map: MKMapView){
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
        interNetSerVice.dealWithJSON { (json) in
            self.analyzeJSON(with: json)
            //注意,將TabbarControoler鑲嵌進NavigattionController之後
            //每一個獨立的NavigattionController等同之前的Viewcontroller
            //先透過viewControllers[?]取得NavigattionController(記得轉型)
            //轉型後再一次的viewControllers[?]取得Viewcontroller(記得轉型)
            let navigaationController_Second = self.tabBarController?.viewControllers![1] as! UINavigationController
            let listStationController = navigaationController_Second.viewControllers[0] as! ListStationController

            listStationController.bikeStationArray = self.bikeStationArray
        }
        userMap.setRegion(mapRegion, animated: true)
       
        
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
