//
//  LessonDurationView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class PaymentSliderView:SliderView {
    override func setupView() {
        super.setupView()
        
        maxValue = 500
        startValue = 50
        label.text = "\(Int(startValue)) $"
        minLabel.text = "0 $"
        maxLabel.text = "\(Int(maxValue)) $"
        slider.setValue(self.startValue/self.maxValue, animated: true)
    }
    
    override func handleSliderValueChanges() {
        label.text = String(Int(slider.value * maxValue)) + " $"
    }
}

class DurationSliderView:SliderView {
    override func setupView() {
        super.setupView()
        
        maxValue = 180
        startValue = 45
        label.text = "\(Int(startValue)) Minutes"
        minLabel.text = "0 min"
        maxLabel.text = "\(Int(maxValue)) min"
        slider.setValue(self.startValue/self.maxValue, animated: true)
    }
    
    override func handleSliderValueChanges() {
        label.text = String(Int(slider.value * maxValue)) + " Minutes"
    }
}

class SliderView:CustomView {
    
    var maxValue:Float = 0
    var startValue:Float = 0
    
    var currentValue:Int {
        get {
            return Int(slider.value * maxValue)
        }
    }
    
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
    
       fileprivate let label:UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
         label.textColor = .white
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    
    fileprivate let minLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let maxLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
           label.textColor = .lightGray
           label.textAlignment = .right
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    fileprivate lazy var slider:UISlider = {
        [unowned self] in
        let view = UISlider()
        view.addTarget(self, action: #selector(handleSliderValueChanges), for: .valueChanged)
        view.backgroundColor = UIColor.MyTheme.extraDarkBG
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

    
    @objc fileprivate func handleSliderValueChanges() {
    }
    
    private func setSubviews() {
        
        addSubview(line)
        addSubview(squareContainer)
        addSubview(slider)
        addSubview(minLabel)
        addSubview(maxLabel)
        squareContainer.addSubview(label)
        
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: squareContainer)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: line)
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: slider)
        addConstraintsWithFormat(format: "H:|-24-[v0(50)]", views:  minLabel)
        addConstraintsWithFormat(format: "H:[v0(100)]-24-|", views: maxLabel)
        
        let constraints = [
            line.topAnchor.constraint(equalTo: self.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
    
            squareContainer.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 20),
            squareContainer.heightAnchor.constraint(equalToConstant: 65),
            
            label.centerYAnchor.constraint(equalTo: squareContainer.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: squareContainer.centerXAnchor),
            label.widthAnchor.constraint(equalTo: squareContainer.widthAnchor),
            
            slider.topAnchor.constraint(equalTo: squareContainer.bottomAnchor,constant: 24),
            
            minLabel.topAnchor.constraint(equalTo: slider.bottomAnchor,constant: 2),
            
            maxLabel.topAnchor.constraint(equalTo: slider.bottomAnchor,constant: 2)
            
        ]
        
        constraints.forEach { $0.isActive = true }
    }
}
