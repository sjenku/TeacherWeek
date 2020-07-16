//
//  LessonDurationView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class LessonDurationView:CustomView {
    
    private let line:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let squareContainer:UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
          view.backgroundColor = UIColor.MyTheme.extraDarkBG
          return view
      }()
    
       private let minutesLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
         label.textColor = .white
         label.textAlignment = .center
         label.text = "45 minutes"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    
    private let minMinutesLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "0 min"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxMinutesLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
           label.textColor = .lightGray
           label.textAlignment = .right
           label.text = "180 min"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    private lazy var slider:UISlider = {
        let view = UISlider()
        view.addTarget(self, action: #selector(handleSliderValueChanges), for: .valueChanged)
        view.backgroundColor = UIColor.MyTheme.extraDarkBG
        view.setValue(45/180, animated: true)
        view.tintColor = UIColor.MyTheme.lightGreen
        view.thumbTintColor = UIColor.MyTheme.lightGreen
        setNeedsLayout()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }

    
    @objc private func handleSliderValueChanges() {
        minutesLabel.text = String(Int(slider.value * 180)) + " Minutes"
    }
    
    private func setSubviews() {
        
        addSubview(line)
        addSubview(squareContainer)
        addSubview(slider)
        addSubview(minMinutesLabel)
        addSubview(maxMinutesLabel)
        squareContainer.addSubview(minutesLabel)
        
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: squareContainer)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: line)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: slider)
        addConstraintsWithFormat(format: "H:|-24-[v0(50)]", views:  minMinutesLabel)
        addConstraintsWithFormat(format: "H:[v0(100)]-24-|", views: maxMinutesLabel)
        
        let constraints = [
            line.topAnchor.constraint(equalTo: self.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
    
            squareContainer.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 20),
            squareContainer.heightAnchor.constraint(equalToConstant: 65),
            
            minutesLabel.centerYAnchor.constraint(equalTo: squareContainer.centerYAnchor),
            minutesLabel.centerXAnchor.constraint(equalTo: squareContainer.centerXAnchor),
            minutesLabel.widthAnchor.constraint(equalTo: squareContainer.widthAnchor),
            
            slider.topAnchor.constraint(equalTo: squareContainer.bottomAnchor,constant: 24),
            
            minMinutesLabel.topAnchor.constraint(equalTo: slider.bottomAnchor,constant: 2),
            
            maxMinutesLabel.topAnchor.constraint(equalTo: slider.bottomAnchor,constant: 2)
            
        ]
        
        constraints.forEach { $0.isActive = true }
    }
}
