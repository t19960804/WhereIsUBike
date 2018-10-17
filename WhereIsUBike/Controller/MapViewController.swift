//
//  MapViewController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/15.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    var locationManager = CLLocationManager()
    let interNetService = InterNetService()
    @IBOutlet weak var userMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        interNetService.dealWithJSON(map: userMap)
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
        
        
    }
    
    

}
extension MapViewController: CLLocationManagerDelegate{
    //顯示特定區域 -> 座標 + 縮放範圍
    //當使用者座標改變後觸發
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentValue = manager.location?.coordinate else{return}
        guard let userLocation = locations.last else{return}
        //放大比例(latitudeDelta/longitudeDelta)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta:0.003 )
        
        let mapRegion = MKCoordinateRegion.init(center: userLocation.coordinate, span: mapSpan)
        
        userMap.setRegion(mapRegion, animated: true)
        print(currentValue.latitude)
        print(currentValue.longitude)
        
        
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
        print(stationTitle!)
        return annotationView
    }
    
}
