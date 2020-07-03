//
//  TitleAndTextFieldView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class TitleAndTextFieldView:CustomView {
    
    
    
    let title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 35)
        return label
    }()
    
    let textField:CustomTextField = {
        let tf = CustomTextField()
        return tf
    }()
    

    var placeHolder:String = "" {
        willSet {
            textField.placeHolder = newValue
        }
    }
    
    override func setupView() {
        super.setupView()

        
        addSubview(title)
        addSubview(textField)
        setConstraints()
        
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|[v0]|", views: title)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: textField)
        addConstraintsWithFormat(format: "V:|[v0]-4-[v1]|", views: title,textField)
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    
}
