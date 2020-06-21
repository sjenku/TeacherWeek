//
//  ListViewCell.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 19/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ListViewCell: CustomCollectionViewCell {
    
    //MARK: - Views
    
    let title:UILabel = {
          let label = UILabel()
          label.adjustsFontSizeToFitWidth = true
          label.textColor = .white
          label.text = "Student Name"
          label.font = UIFont.systemFont(ofSize: 20, weight: .light)
          return label
      }()
      
      let accessory:UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate)
          iv.tintColor = UIColor.MyTheme.lightBlue
          iv.isHidden = true
          iv.contentMode = .scaleAspectFit
          return iv
      }()
    
     //MARK: - Private Properties
     
     var isAccessoryShown:Bool {
         get {
             return !accessory.isHidden
         }
         set {
             accessory.isHidden = !newValue
         }
     }
 
    
    //MARK: - Overrides
    
    
    
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
    
    
    override func setupView() {
        
        backgroundColor = UIColor.MyTheme.cellColor
        addSubview(title)
        addSubview(accessory)
        
        addConstraintsWithFormat(format:"H:|-16-[v0][v1]-16-|", views:title,accessory)
        addConstraintsWithFormat(format:"V:|[v0]|", views: title)
        addConstraintsWithFormat(format:"V:|-12-[v0]-12-|", views: accessory)
        addConstraint(NSLayoutConstraint(item: accessory, attribute: .width, relatedBy: .equal, toItem: accessory, attribute: .height, multiplier: 1, constant: 0))
        
        
    }

    
}
