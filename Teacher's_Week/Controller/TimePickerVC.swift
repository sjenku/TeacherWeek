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
    

    private let header:UILabel = {
        let label = UILabel()
        label.text = "Day For The\nLesson?"
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton:GenerateSOTitleBTView = {
           let button = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

    private let arrowPointingRight:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow.right")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let arrowPointingLeft:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow.left")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
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
        
        view.addSubview(header)
        view.addSubview(nextButton)
        view.addSubview(pickerView)
        view.addSubview(arrowPointingRight)
        view.addSubview(arrowPointingLeft)
        
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: header)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: nextButton)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: pickerView)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]", views: arrowPointingRight)
        view.addConstraintsWithFormat(format: "H:[v0]-24-|", views: arrowPointingLeft)
        
        let additionalConstraints = [
            header.bottomAnchor.constraint(equalTo: pickerView.topAnchor,constant: 8),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1),
            
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 2),
            
            arrowPointingRight.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowPointingRight.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            arrowPointingRight.widthAnchor.constraint(equalTo: arrowPointingRight.heightAnchor),
            
            arrowPointingLeft.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowPointingLeft.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            arrowPointingLeft.widthAnchor.constraint(equalTo: arrowPointingRight.heightAnchor)
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
