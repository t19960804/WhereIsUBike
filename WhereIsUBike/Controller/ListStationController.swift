//
//  ListStationController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListStationController: UIViewController {
    let interNetService = InterNetService()
    var bikeStationArray = [BikeStationData]()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "附近站點"
        label.font = label.font.withSize(30.0)
        label.textAlignment = .center
        return label
    }()
    let seperateLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    let bikeStationList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BikeListCell.self, forCellReuseIdentifier: "Cell")
        //隱藏滾動條
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeStationList.delegate = self
        bikeStationList.dataSource = self
        self.view.addSubview(titleLabel)
        self.view.addSubview(bikeStationList)
        self.view.addSubview(seperateLine)
        setUpConstraints()
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
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
        seperateLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        seperateLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        seperateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperateLine.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        
        bikeStationList.topAnchor.constraint(equalTo: seperateLine.bottomAnchor, constant: 0).isActive = true
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
}
