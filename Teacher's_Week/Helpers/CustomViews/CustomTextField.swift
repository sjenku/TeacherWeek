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
        tv.adjustsFontSizeToFitWidth = true
        tv.textAlignment = .center
        tv.delegate = self
        tv.layer.cornerRadius = 10
        tv.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tv.textColor = UIColor.darkGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var placeHolder:String = "" {
        willSet {
            textField.placeholder = newValue
        }
    }
    
    override var tag: Int {
        willSet {
            textField.tag = newValue
        }
    }
    
    static weak var currentActive:UITextField?
    
    override func setupView() {
        super.setupView()
        
        addSubview(textField)
        backgroundColor = .clear
        addConstraintsWithFormat(format: "H:|[v0]|", views: textField)
        addConstraintsWithFormat(format: "V:|[v0]|", views: textField)
    }
    
}


//MARK: - UITextFieldDelegate
extension CustomTextField:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        CustomTextField.currentActive = textField
        return true
    }
}
