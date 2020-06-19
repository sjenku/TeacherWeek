//
//  ChooseCollectionViewCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 19/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionViewCell: CustomCollectionViewCell {
    
    let personNameLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = "Student Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    let checkMarkIcon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.MyTheme.lightBlue
        iv.isHidden = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.backgroundColor = newValue ? UIColor.MyTheme.lightGreen : UIColor.MyTheme.cellColor
            }
        }
    }
  
    
    var isChecked:Bool {
        get {
            return !checkMarkIcon.isHidden
        }
        set {
            checkMarkIcon.isHidden = !newValue
        }
    }
    
    
  
    
    override func setupView() {
        
        backgroundColor = UIColor.MyTheme.cellColor
        addSubview(personNameLabel)
        addSubview(checkMarkIcon)
        
        addConstraintsWithFormat(format:"H:|-16-[v0][v1]-16-|", views:personNameLabel,checkMarkIcon)
        addConstraintsWithFormat(format:"V:|[v0]|", views: personNameLabel)
        addConstraintsWithFormat(format:"V:|-12-[v0]-12-|", views: checkMarkIcon)
        addConstraint(NSLayoutConstraint(item: checkMarkIcon, attribute: .width, relatedBy: .equal, toItem: checkMarkIcon, attribute: .height, multiplier: 1, constant: 0))
        
        
    }
}
