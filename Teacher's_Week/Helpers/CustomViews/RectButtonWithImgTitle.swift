//
//  RectButtonWithImgTitle.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class RectButtonWithImgTitle:UIButton {
    
    //MARK: - Views
    
    let btImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let btTitle:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Properties
    

    var notHighlightedColor:UIColor?
    var highlightedColor:UIColor?
    
    var shadowColor:UIColor?  {
        willSet {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    
    override var buttonType: UIButton.ButtonType {
        return ButtonType.custom
    }
    
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = highlightedColor
                btImageView.tintColor = UIColor.white
            }
            else {
                backgroundColor = notHighlightedColor
            }
            super.isHighlighted = newValue
        }
    }
    
    
    
    //MARK: - Init
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        addSubview(btImageView)
        addSubview(btTitle)
    }
    

    
    
    //MARK: - Manage View Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //radius
        setLayer()
  
        // Constraints
       setConstriants()
        
    }
    
    private func setConstriants() {
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: btImageView)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: btTitle)
        addConstraintsWithFormat(format: "V:|-24-[v0][v1]-16-|", views: btImageView,btTitle)
        addConstraint(NSLayoutConstraint(item: btImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1/2, constant: 0))
    }
    
    private func setLayer() {
        layer.cornerRadius = 10
        if shadowColor != nil {
        layer.shadowRadius = 5
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
