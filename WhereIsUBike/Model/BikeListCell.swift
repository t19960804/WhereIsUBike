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
    let stationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.textAlignment = .left
        return label
    }()
    let numberCanBorrow: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    }()
    let numberCanReturn: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        return label
    }()
    lazy var labelStackView_Number: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberCanBorrow,numberCanReturn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    let numberCanReturn_Pure: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.text = "可還"
        return label
    }()
    let numberCanBorrow_Pure: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.text = "可借"
        return label
    }()
    lazy var labelStackView_Text: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberCanReturn_Pure,numberCanBorrow_Pure])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    let stationDistane: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        return label
    }()
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
        stationTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        stationTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        stationTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        stationDistane.topAnchor.constraint(equalTo: self.stationTitle.bottomAnchor, constant: -3).isActive = true
        stationDistane.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        stationDistane.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        stationDistane.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        labelStackView_Text.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelStackView_Text.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        
        labelStackView_Number.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelStackView_Number.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
