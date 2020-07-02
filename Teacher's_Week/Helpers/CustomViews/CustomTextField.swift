//
//  CustomTextField.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class CustomTextField:CustomView {
    
    lazy var textField:UITextField = {
            let tv = UITextField()
            tv.backgroundColor = UIColor.MyTheme.textFieldColor
            tv.placeholder = "Your Group Name"
            tv.adjustsFontSizeToFitWidth = true
            tv.textAlignment = .center
            tv.layer.cornerRadius = 10
            tv.delegate = self
            tv.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            tv.textColor = UIColor.darkGray
            tv.translatesAutoresizingMaskIntoConstraints = false
            return tv
        }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(textField)
        backgroundColor = .clear
        addConstraintsWithFormat(format: "H:|[v0]|", views: textField)
        addConstraintsWithFormat(format: "V:|[v0]|", views: textField)
    }
    
}

extension CustomTextField:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
       }
    
    
}
