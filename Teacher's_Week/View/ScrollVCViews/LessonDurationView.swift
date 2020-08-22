//
//  LessonDurationView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 16/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class SliderView:CustomView {
    
    var maxValue:Float
    var startValue:Float
    var sign:String
    
    var currentValue:Int {
        get {
            return Int(slider.value * maxValue)
        }
        set {
            slider.value = Float(newValue)/maxValue
            label.text = "\(newValue) " + sign
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
        print("StartValue:\(self.startValue)")
        view.setValue(startValue/maxValue, animated: true)
        return view
    }()
    
    
    init(startValue:Float,maxValue:Float,sign:String) {
        self.startValue = startValue
        self.maxValue = maxValue
        self.sign = sign
        super.init(frame: .zero)
        
        label.text = "\(Int(startValue)) " + sign
        minLabel.text = "0 " + sign
        maxLabel.text = "\(Int(maxValue)) " + sign
    }
    
    required init?(coder: NSCoder) {
        self.startValue = 0
        self.maxValue = 0
        self.sign = ""
        super.init(frame: .zero)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        
        setSubviews()
        setConstraints()
    }

    
    @objc fileprivate func handleSliderValueChanges() {
        label.text = String(Int(slider.value * maxValue)) + " " + sign
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
