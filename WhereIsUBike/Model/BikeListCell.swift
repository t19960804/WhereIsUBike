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
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        return label
    }()
    let numberCanBorrow: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.text = "text"
        return label
    }()
    let numberCanReturn: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.text = "text"
        return label
    }()
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberCanBorrow,numberCanReturn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.backgroundColor = UIColor.green
        return stackView
    }()
    //呼叫UITableViewCell的指定建構器
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(stationTitle)
        self.addSubview(labelStackView)
        
        setUpConstraints()
    }
    
    func setUpConstraints(){
        stationTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stationTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        stationTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        stationTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        labelStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelStackView.topAnchor.constraint(equalTo: stationTitle.bottomAnchor, constant: 8).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
