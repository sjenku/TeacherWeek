//
//  TimePickerVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class TimePickerVC:UIViewController {
    
    private let daysArray = [
    "Sunday","Monday","Thuersday","Wednsday","Thuesday","Friday","Suaterday"
    ]
    
    private let nextButton:GenerateSOTitleBTView = {
           let button = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

    
    private lazy var pickerView:UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        
        view.addSubview(nextButton)
        view.addSubview(pickerView)
        
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: nextButton)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: pickerView)
        
        let additionalConstraints = [
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1),
            
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 2)
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
    
    
    
}

//MARK: - Extensions

extension TimePickerVC:UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return DeviceConfigurations.windowHeight / 15
    }
    
}


extension TimePickerVC:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = daysArray[row]
        label.textColor = UIColor.MyTheme.extraLightGray
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }
}
