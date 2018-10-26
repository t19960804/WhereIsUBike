//
//  BugReportController.swift
//  WhereIsUBike
//
//  Created by t19960804 on 2018/10/25.
//  Copyright © 2018 t19960804. All rights reserved.
//

import UIKit

class BugReportController: UIViewController {
    let backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bugDate_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "日期"
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1)
        //label.backgroundColor = UIColor.red
        return label
    }()
    let bugDate_Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("請選擇", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(showDatePicker), for: UIControl.Event.touchUpInside)
        //button.backgroundColor = UIColor.gray
        return button
    }()
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let localLanguage = Locale(identifier: "zh")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        //設定中文
        picker.locale = localLanguage
        picker.addTarget(self, action: #selector(pickerValueChanged), for: UIControl.Event.valueChanged)
        return picker
    }()
    let close_DatePicker: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cancel"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(closeDatePicker), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var bugDate_StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bugDate_Label,bugDate_Button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    /////
    let bugTitle_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "標題"
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1)
        //label.backgroundColor = UIColor.orange
        return label
    }()
    let bugTitle_TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "請輸入"
        textField.font = textField.font?.withSize(20)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1).cgColor
        textField.layer.cornerRadius = 5
        //textField.backgroundColor = UIColor.red
        return textField
    }()
    lazy var bugTitle_StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bugTitle_Label,bugTitle_TextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    /////

    let bugDiscription_Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "問題敘述"
        label.font = label.font.withSize(20)
        label.textColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1)
        return label
    }()
    
    let bugDiscription_TextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        //textView.font = textView.font?.withSize(18)
        //textView.backgroundColor = UIColor.red
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1).cgColor
        textView.layer.cornerRadius = 5
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        bugDiscription_TextView.delegate = self
        bugTitle_TextField.delegate = self
        self.view.addSubview(backGroundView)
        backGroundView.addSubview(bugDate_StackView)
        backGroundView.addSubview(bugTitle_StackView)
        backGroundView.addSubview(bugDiscription_Label)
        backGroundView.addSubview(bugDiscription_TextView)
        setUpConstraints()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: - DatePicker處理
    @objc func showDatePicker(){
        self.view.addSubview(datePicker)
        self.view.addSubview(close_DatePicker)
        datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        datePicker.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        datePicker.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        datePicker.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        datePicker.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        close_DatePicker.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: 10).isActive = true
        close_DatePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        close_DatePicker.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        close_DatePicker.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
    }
    @objc func pickerValueChanged(){
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        let dateToday = format.string(from: datePicker.date)
        bugDate_Button.setTitle(dateToday, for: UIControl.State.normal)
    }
    @objc func closeDatePicker(){
        self.datePicker.removeFromSuperview()
        self.close_DatePicker.removeFromSuperview()
    }
    //MARK: - Constraints處理
    func setUpConstraints(){
        
        backGroundView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 64).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -44).isActive = true
        backGroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 0).isActive = true
        backGroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: 0).isActive = true
        /////
        bugDate_StackView.topAnchor.constraint(equalTo: backGroundView.topAnchor, constant: 30).isActive = true
        bugDate_StackView.heightAnchor.constraint(equalTo: backGroundView.heightAnchor, multiplier: 0.1).isActive = true
//        bugDate_StackView.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 0.9).isActive = true
        bugDate_StackView.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 0.65).isActive = true

        bugDate_StackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        
        bugDate_Label.widthAnchor.constraint(lessThanOrEqualTo: bugDate_StackView.widthAnchor, multiplier: 0.25).isActive = true
//        bugDate_Label.widthAnchor.constraint(lessThanOrEqualTo: bugDate_StackView.widthAnchor, multiplier: 0.2).isActive = true
//        bugDate_Button.widthAnchor.constraint(lessThanOrEqualTo: bugDate_StackView.widthAnchor, multiplier: 0.78).isActive = true

        bugDate_Button.widthAnchor.constraint(lessThanOrEqualTo: bugDate_StackView.widthAnchor, multiplier: 0.75).isActive = true
        /////
        bugTitle_StackView.topAnchor.constraint(equalTo: bugDate_StackView.bottomAnchor, constant: 25).isActive = true
        bugTitle_StackView.heightAnchor.constraint(equalTo: backGroundView.heightAnchor, multiplier: 0.1).isActive = true
        bugTitle_StackView.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 0.9).isActive = true
        bugTitle_StackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        bugTitle_Label.widthAnchor.constraint(lessThanOrEqualTo: bugTitle_StackView.widthAnchor, multiplier: 0.2).isActive = true
        bugTitle_TextField.widthAnchor.constraint(lessThanOrEqualTo: bugTitle_StackView.widthAnchor, multiplier: 0.8).isActive = true
        /////
        bugDiscription_Label.topAnchor.constraint(equalTo: bugTitle_StackView.bottomAnchor, constant: 25).isActive = true
        bugDiscription_Label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        bugDiscription_Label.heightAnchor.constraint(equalTo: backGroundView.heightAnchor, multiplier: 0.07).isActive = true
        bugDiscription_Label.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 0.3).isActive = true
        
        bugDiscription_TextView.topAnchor.constraint(equalTo: bugDiscription_Label.bottomAnchor, constant: 0).isActive = true
        bugDiscription_TextView.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -12).isActive = true
        bugDiscription_TextView.centerXAnchor.constraint(equalTo: backGroundView.centerXAnchor).isActive = true
        bugDiscription_TextView.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 0.85).isActive = true

    }


}
extension BugReportController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor(red: 50 / 255, green: 137 / 255, blue: 199 / 255, alpha: 1).cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1).cgColor
    }
}
extension BugReportController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 50 / 255, green: 137 / 255, blue: 199 / 255, alpha: 1).cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 146 / 255, green: 154 / 255, blue: 171 / 255, alpha: 1).cgColor
    }
}
