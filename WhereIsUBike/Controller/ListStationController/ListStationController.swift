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
            //
            filteredStationArray = bikeStationArray
        }
    }
    var filteredStationArray = [BikeStationData]()
    
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
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Search...."
        bar.barTintColor = UIColor(red: 50/255, green: 137/255, blue: 199/255, alpha: 1)
        
        return bar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bikeStationList.delegate = self
        bikeStationList.dataSource = self
        searchBar.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.view.addSubview(searchBar)
        self.view.addSubview(bikeStationList)
        bikeStationList.addSubview(refreshControll)
        
        setUpConstraints()
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = bikeStationList.indexPathForSelectedRow else{return}
        let destination = segue.destination as! ListStationController_Detail
        destination.bikeStationData = filteredStationArray[indexPath.row]
    }
    @objc func refreshTableView(){
        bikeStationList.reloadData()
        refreshControll.endRefreshing()
        
    }
    

    func setUpConstraints(){
        
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20 + 44 + 24).isActive = true
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
        return filteredStationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bikeStationList.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BikeListCell
        cell.stationTitle.text = filteredStationArray[indexPath.row].station_Title
        cell.numberCanBorrow.text = "\(filteredStationArray[indexPath.row].station_Borrow)"
        cell.numberCanReturn.text = "\(filteredStationArray[indexPath.row].station_Return)"
        cell.stationDistane.text = "距離:\(filteredStationArray[indexPath.row].station_Distance)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "gotoStationDetail", sender: self)
    }
    
}
//MARK: - SearchBar設定
extension ListStationController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            
            filteredStationArray = bikeStationArray
            bikeStationList.reloadData()
            //如果不加return,會再一次執行亞下面的.filter(),此時searchText是空的將不會有任何結果
            return
        }
        filteredStationArray = bikeStationArray.filter({ (stationData) -> Bool in
            return stationData.station_Title.contains(searchText)
        })
        bikeStationList.reloadData()
        
    }

}

