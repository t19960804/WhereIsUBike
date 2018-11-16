//
//  BikeListCell.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/17.
//  Copyright © 2018 t19960804. All rights reserved.
//
import Foundation

import UIKit


class BikeListCell: UITableViewCell {
    var bikeViewModel: BikeViewModel?{
        didSet{
            stationTitle.text = bikeViewModel!.station_Title
            numberCanBorrow.text = bikeViewModel!.station_Borrow
            numberCanReturn.text = bikeViewModel!.station_Return
            stationDistane.text = "距離:\(bikeViewModel!.station_Distance)"
            self.accessoryType = .disclosureIndicator
        }
    }
 
    let stationTitle = CellLabel(contents: "", fontSize: UIFont.systemFont(ofSize: 25), textColor: nil)
    let numberCanBorrow = CellLabel(contents: "", fontSize: UIFont.systemFont(ofSize: 20), textColor: nil)
    let numberCanReturn = CellLabel(contents: "", fontSize: UIFont.systemFont(ofSize: 20), textColor: nil)
    let numberCanReturn_Pure = CellLabel(contents: "可還", fontSize: UIFont.systemFont(ofSize: 20), textColor: nil)
    let numberCanBorrow_Pure = CellLabel(contents: "可借", fontSize: UIFont.systemFont(ofSize: 20), textColor: nil)
    let stationDistane = CellLabel(contents: "", fontSize: UIFont.systemFont(ofSize: 15), textColor: UIColor.grayColor_Normal)

    lazy var labelStackView_Number = CellStackView(with: numberCanBorrow, with: numberCanReturn)
    lazy var labelStackView_Text = CellStackView(with: numberCanReturn_Pure, with: numberCanBorrow_Pure)


   
    //呼叫UITableViewCell的指定建構器
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(stationTitle)
        self.addSubview(labelStackView_Number)
        self.addSubview(labelStackView_Text)
        self.addSubview(stationDistane)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        stationTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        stationTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        stationTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        stationTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        
        stationDistane.topAnchor.constraint(equalTo: self.stationTitle.bottomAnchor, constant: -3).isActive = true
        stationDistane.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        stationDistane.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        stationDistane.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        labelStackView_Text.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelStackView_Text.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -75).isActive = true
        
        labelStackView_Number.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelStackView_Number.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        
        

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
