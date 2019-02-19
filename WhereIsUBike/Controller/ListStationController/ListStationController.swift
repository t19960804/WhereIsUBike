//
//  ListStationController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import SVProgressHUD

class ListStationController: UIViewController {
    var bikeViewModelArray = [BikeViewModel](){
        didSet{
            filteredBikeViewModelArray = bikeViewModelArray
        }
    }
   
    var filteredBikeViewModelArray = [BikeViewModel]()
    
    let bikeStationList = StationTableView(reuseIdentifier: "Cell")
    let searchBar = SearchBar(placeHolder: "Search....", tintColor: UIColor.blueColor_Theme)
    let refreshControl: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.tintColor = UIColor.blueColor_Theme
        controll.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        return controll
    }()
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.bikeStationList.keyboardDismissMode = .interactive
        setting_DelegateAndDatasource()
        addAllSubviews()
        setUpConstraints()
    }
    func reloadTableView(){
        DispatchQueue.main.async {
            self.bikeStationList.reloadData()
        }
    }
    fileprivate func mapNavigation(stationName: String,station_Lat: Double,station_Long: Double){
        //終點座標
        let coordinates = CLLocationCoordinate2D(latitude: station_Lat, longitude: station_Long)
        // 确定半径(用coordinate當中心點,畫一個圓的半徑,單位公尺)
        let regionDistance: CLLocationDistance = 1000
        //map中心點
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        //對於map的額外設定,可以是nil
        let options = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: regionSpan.center),
                       MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan: regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = "\(stationName)"
        
        mapItem.openInMaps(launchOptions: options)
    }
    fileprivate func setting_DelegateAndDatasource(){
        bikeStationList.delegate = self
        bikeStationList.dataSource = self
        searchBar.delegate = self
    }
    fileprivate func addAllSubviews(){
        self.view.addSubview(searchBar)
        self.view.addSubview(bikeStationList)
        bikeStationList.addSubview(refreshControl)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {self.view.endEditing(true)}
    
    @objc func refreshTableView(){
        reloadTableView()
        refreshControl.endRefreshing()
    }
    func setUpConstraints(){
        let safeAreaHeight_Top = UIApplication.shared.keyWindow!.safeAreaInsets.top
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeAreaHeight_Top + 96 ).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true

        searchBar.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        searchBar.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        bikeStationList.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 0).isActive = true
        bikeStationList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bikeStationList.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bikeStationList.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
    }
}
//MARK: - TableView設定
extension ListStationController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBikeViewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bikeStationList.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BikeListCell
        //將對應的ViewModel傳給View觀察
        cell.bikeViewModel = self.filteredBikeViewModelArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationName = filteredBikeViewModelArray[indexPath.row].station_Title
        let stationLatitude = filteredBikeViewModelArray[indexPath.row].station_Lat
        let stationLongitude = filteredBikeViewModelArray[indexPath.row].station_Lng
        mapNavigation(stationName: stationName, station_Lat: Double(stationLatitude) ?? 0.0, station_Long: Double(stationLongitude) ?? 0.0)
        searchBar.text = ""
    }
    
}
//MARK: - SearchBar設定
extension ListStationController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            
            filteredBikeViewModelArray = bikeViewModelArray
            reloadTableView()
            //如果不加return,會再一次執行亞下面的.filter(),此時searchText是空的將不會有任何結果
            return
        }

        filteredBikeViewModelArray = bikeViewModelArray.filter{$0.station_Title.contains(searchText)}
        reloadTableView()
        
    }

}



