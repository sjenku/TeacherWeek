//
//  RoundButtonWithIcon.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class RoundButtonWithIcon:UIButton {
    
    let btImageView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var isHighlightedColor:UIColor = {
        return UIColor.white
    }()
    
    override var buttonType: UIButton.ButtonType {
        return ButtonType.custom
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.MyTheme.darkBG
        addSubview(btImageView)
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = isHighlightedColor
            }
            else {
                backgroundColor = UIColor.MyTheme.darkBG
            }
            super.isHighlighted = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //radius
        setLayer()
  
        //btImageView Constraints
        addConstraint(NSLayoutConstraint(item: btImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: btImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        let padding:CGFloat = frame.height / 4
        addConstraintsWithFormat(format: "H:|-\(padding / 1.2)-[v0]-\(padding / 1.2)-|", views: btImageView)
        addConstraintsWithFormat(format: "V:|-\(padding)-[v0]-\(padding)-|", views: btImageView)
        
    }
    
    private func setLayer() {
           layer.cornerRadius = frame.width / 2
           let factor = layer.cornerRadius
           layer.shadowColor = UIColor.MyTheme.lightGreen.cgColor
           layer.shadowRadius = factor / 4
           layer.masksToBounds = false
           layer.shadowOpacity = 0.4
           layer.shadowOffset = CGSize(width: 0, height: 0)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
