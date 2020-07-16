//
//  StepperWithCounter.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class StepperWithCounter:CustomView {
    
    
    //MARK: - Properties
    
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
    
    private let counter:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stepper:UIStepper = {
        [unowned self] in
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
        stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
        stepper.addTarget(self, action: #selector(handleStepperValueChanged), for: .touchUpInside)
        stepper.tintColor = .white
        return stepper
    }()
    
   private let padding:CGFloat = 36
    
    
    //MARK: - Public Methods
    
    func setSubviewsEnable(_ enable:Bool) {
        switch enable {
        case true:
            stepper.isEnabled = true
            counter.text = String(Int(stepper.value))
            squareContainer.backgroundColor = UIColor.MyTheme.extraDarkBG
        default:
            stepper.isEnabled = false
            counter.text = "-"
            squareContainer.backgroundColor = .lightGray
        }
    }
    
    //MARK: - Overrides
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
        
        
    }
   
    //MARK: - OBJC Private Methods
    
    @objc private func handleStepperValueChanged() {
        counter.text = String(Int(stepper.value))
    }
    
    //MARK: - Private Methods
    
    private func setSubviews() {
        addSubview(line)
        addSubview(squareContainer)
        addSubview(stepper)
        
        squareContainer.addSubview(counter)
    }
    
    private func setConstraints() {
        
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: line)
        
        let constraints = [
            line.topAnchor.constraint(equalTo: self.topAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            
            squareContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            squareContainer.trailingAnchor.constraint(equalTo: self.centerXAnchor,constant: -padding),
            squareContainer.heightAnchor.constraint(equalToConstant: 90),
            squareContainer.widthAnchor.constraint(equalTo:squareContainer.heightAnchor),
            
            stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stepper.leadingAnchor.constraint(equalTo: self.centerXAnchor,constant: padding),
            
            counter.centerXAnchor.constraint(equalTo: squareContainer.centerXAnchor),
            counter.centerYAnchor.constraint(equalTo: squareContainer.centerYAnchor)
            
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
