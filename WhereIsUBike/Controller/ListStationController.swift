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
    var bikeStationArray = [BikeStationData]()
    
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
        getJSON()
        
        
    }
    
    
    @objc func refreshTableView(){
        getJSON()
        refreshControll.endRefreshing()
    }
    
    func getJSON(){
        interNetService.dealWithJSON { (json) in
            self.analyzeJSON(with: json)
            self.bikeStationList.reloadData()

        }
    }
    
    func analyzeJSON(with json: JSON) {
        for jsonObject in json.arrayValue{
            
            let name = jsonObject["sna"].stringValue
            let number_Borrow = jsonObject["sbi"].stringValue
            let number_Return = jsonObject["bemp"].stringValue
            
            let bikeStation = BikeStationData(station_Title: name,bike_Borrow: number_Borrow,bike_Return: number_Return)
            bikeStationArray.append(bikeStation)
            
        }
        
    }
   
    func setUpConstraints(){
        
        
        
        bikeStationList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
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
        cell.numberCanBorrow.text = "可借:\(bikeStationArray[indexPath.row].bike_Borrow)"
        cell.numberCanReturn.text = "可還:\(bikeStationArray[indexPath.row].bike_Return)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
}
