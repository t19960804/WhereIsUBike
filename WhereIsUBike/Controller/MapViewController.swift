//
//  MapViewController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
class MapViewController: UIViewController {
    var locationManager = CLLocationManager()
    var interNetSerVice = InterNetService()
    var userLocation = CLLocation()
    @IBOutlet weak var userMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userMap.delegate = self
        // 顯示自身定位位置
        userMap.showsUserLocation = true
        // 允許縮放地圖
        userMap.isZoomEnabled = true
        //userMap.userLocation.title = ""
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
        }
       
    }

    func analyzeJSON(with json: JSON) {
        for jsonObject in json.arrayValue{
            let lat = jsonObject["lat"].stringValue
            let lng = jsonObject["lng"].stringValue
            let name = jsonObject["sna"].stringValue
            let number_Borrow = jsonObject["sbi"].stringValue
            let number_Return = jsonObject["bemp"].stringValue
            let distance = userLocation.distance(from: CLLocation(latitude: Double(lat) ?? 0.0, longitude: Double(lng) ?? 0.0))
            addAnnotations(lattitude: Double(lat) ?? 0.0, longtitude: Double(lng) ?? 0.0,stationName: name,canBorrow: number_Borrow,canReturn: number_Return,map: userMap)
            
            print("\(name),lat:\(lat) lng:\(lng)")
            print("\(name),距離:\(Int(distance))公尺 \n\n")
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
        
        guard let coordinate = manager.location?.coordinate else{return}
        let currentLocationValue = coordinate
        guard let newestLocation = locations.last else {return}
        userLocation = newestLocation
        //放大比例(latitudeDelta/longitudeDelta)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta:0.003 )
        
        let mapRegion = MKCoordinateRegion.init(center: userLocation.coordinate, span: mapSpan)
        
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
