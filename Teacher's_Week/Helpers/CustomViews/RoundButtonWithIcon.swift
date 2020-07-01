//
//  RoundButtonWithIcon.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

//MARK: - RoundButton

class RoundButton:UIButton {
    
    var isHighlightedColor:UIColor = {
        return UIColor.white
    }()

    
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
    
}

class RoundButtonWithIcon:UIView {
    
   //MARK: - Views
    
    let circleButton:RoundButton = {
        let button = RoundButton(type: .custom)
        button.backgroundColor = UIColor.MyTheme.darkBG
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let btImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //MARK: - Properties
    
    var shadowColor:UIColor?  {
        willSet {
            circleButton.layer.shadowColor = newValue?.cgColor ?? UIColor.white.cgColor
        }
    }
    
    var isHighlightedColor:UIColor = UIColor.white {
        willSet {
            self.circleButton.isHighlightedColor = newValue
        }
    }
    
    private var heightEqualWidthConstraints:[NSLayoutConstraint]?
    private var widthEqualHeightConstraints:[NSLayoutConstraint]?
    
    
    //MARK: - Overrides
    
    
    override func layoutSubviews() {
          super.layoutSubviews()
          
          //radius
          setLayer()
          
          //Now When You Know The Height,Activate Propriate Constraints for width and height
          if frame.height < frame.width {
              widthEqualHeightConstraints?.forEach({ (constraint) in
                  constraint.isActive = true
              })
              heightEqualWidthConstraints?.forEach({ (constraint) in
                  constraint.isActive = false
              })
          } else {
              widthEqualHeightConstraints?.forEach({ (constraint) in
                  constraint.isActive = false
              })
              heightEqualWidthConstraints?.forEach({ (constraint) in
                  constraint.isActive = true
              })
              
          }
          
      }
      
    
    //MARK: - Override Init
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        addSubview(circleButton)
        addSubview(btImageView)
        setConstraints()
    }
    
   
    //MARK: - Private Methods
    private func setConstraints() {
        
        //btImageViewConstraints
        let constraints = [
            btImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
     
        
        heightEqualWidthConstraints = [
          btImageView.widthAnchor.constraint(equalTo:self.widthAnchor,multiplier: 1/2),
          btImageView.heightAnchor.constraint(equalTo:btImageView.widthAnchor),
          circleButton.widthAnchor.constraint(equalTo: self.widthAnchor),
          circleButton.heightAnchor.constraint(equalTo: circleButton.widthAnchor)
        ]
        
        widthEqualHeightConstraints = [
            btImageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 1/2),
            btImageView.widthAnchor.constraint(equalTo: btImageView.heightAnchor),
            circleButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            circleButton.widthAnchor.constraint(equalTo: circleButton.heightAnchor)
        ]
        
        
        
    }
    
    private func setLayer() {
        circleButton.layer.cornerRadius = circleButton.frame.width / 2
        let factor = circleButton.layer.cornerRadius
        
        if shadowColor != nil {
        circleButton.layer.shadowRadius = factor / 4
        circleButton.layer.masksToBounds = false
        circleButton.layer.shadowOpacity = 0.4
        circleButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
