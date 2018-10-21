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

class ListStationController: UIViewController {
    let interNetService = InterNetService()
    
    var bikeStationArray = [BikeStationData](){
        didSet{
            bikeStationList.reloadData()
            print("bikeStationArray:\(bikeStationArray.count)")
        }
    }
    let bikeStationList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BikeListCell.self, forCellReuseIdentifier: "Cell")
        //隱藏滾動條
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    let refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.tintColor = UIColor(red: 50/255, green: 137/255, blue: 199/255, alpha: 1)
        controll.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        return controll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeStationList.delegate = self
        bikeStationList.dataSource = self
        self.view.addSubview(bikeStationList)
        bikeStationList.addSubview(refreshControll)
        
        setUpConstraints()
        
        
        
    }

    
    @objc func refreshTableView(){
        
    }
    

    func setUpConstraints(){
        
        
        
        bikeStationList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        bikeStationList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bikeStationList.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bikeStationList.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        

    }


}
extension ListStationController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikeStationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bikeStationList.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BikeListCell
        cell.stationTitle.text = bikeStationArray[indexPath.row].station_Title
        cell.numberCanBorrow.text = "\(bikeStationArray[indexPath.row].station_Borrow)"
        cell.numberCanReturn.text = "\(bikeStationArray[indexPath.row].station_Return)"
        cell.stationDistane.text = "距離:\(bikeStationArray[indexPath.row].station_Distance)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
}
