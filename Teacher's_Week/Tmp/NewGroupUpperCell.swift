//
//  NewGroupUpperCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewGroupUpperCell:CustomCollectionViewCell {
    
    
    //MARK: - Views
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
    
    let containerForBTView:UIView = {
           let view = UIView()
           view.backgroundColor = .clear
           return view
       }()
    
    let addButton:RectButtonWithImgTitle = {
        let button = RectButtonWithImgTitle()
        button.btImageView.image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysOriginal)
        button.btTitle.textAlignment = .center
        button.btTitle.textColor = UIColor.MyTheme.lightBlue
        button.btTitle.text = "Add Student"
        button.backgroundColor = UIColor.MyTheme.addStundentButtonColor
        button.notHighlightedColor = UIColor.MyTheme.addStundentButtonColor
        button.highlightedColor = UIColor.MyTheme.addStundentButtonColor.highlight
        button.shadowColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    
    //MARK: - Override Methods
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.darkBG
        
        addSubview(textField)
        addSubview(containerForBTView)
        addSubview(addButton)
        
        setConstraints()
        handleKeyboard()
        
        
    }
    
    //MARK: - Private Functions
    
    private func handleKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endKeyBoardEditing))
        addGestureRecognizer(tap)
    }

    @objc private func endKeyBoardEditing() {
        endEditing(true)
    }
    
    private func setConstraints() {
        
        var constraints:[NSLayoutConstraint] = [NSLayoutConstraint]()
        
        //TextViewConstraints
        constraints += [
        NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1/7.5, constant: 0),
        NSLayoutConstraint(item: textField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 3/4, constant: 0)
        ]
        
        //ContainerViewConstraints
        constraints += [
            NSLayoutConstraint(item: containerForBTView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerForBTView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerForBTView)
        
        //AddButtonConstraints
       constraints += [
        NSLayoutConstraint(item: addButton, attribute: .centerX, relatedBy: .equal, toItem: containerForBTView, attribute: .centerX, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: addButton, attribute: .centerY, relatedBy: .equal, toItem: containerForBTView, attribute: .centerY, multiplier: 1, constant: 0),
         NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: containerForBTView, attribute: .width, multiplier: 1/2, constant: 0),
         NSLayoutConstraint(item: addButton, attribute: .height, relatedBy: .equal, toItem: containerForBTView, attribute: .height, multiplier: 2/3, constant: 0)
        ]
        
        addConstraints(constraints)
   
        
    }
    

    
}

//MARK: - UITextFieldDelegate

extension NewGroupUpperCell:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
