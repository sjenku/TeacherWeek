//
//  HomeView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 15/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class HomeView:CustomView {
    
    let upperContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    var lowerContainer:HomeLowerContainerView = HomeLowerContainerView()
    
    
   override func setupView () {
    
        backgroundColor = UIColor.MyTheme.darkBG
    
        //Set Containers
        let padding:CGFloat = 16
        let heightUpperC = frame.height / 4.5
        let heightLowerC = frame.height - heightUpperC - padding
    
    
        addSubview(lowerContainer)
        addSubview(upperContainer)
    
        addConstraintsWithFormat(format: "H:|[v0]|", views: upperContainer)
        addConstraintsWithFormat(format: "V:|[v0(\(heightUpperC))]-\(padding)-[v1(\(heightLowerC))]", views: upperContainer,lowerContainer)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lowerContainer)
        
    }
}


class HomeLowerContainerView:CustomView {
    
    let upperHalfStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    let lowerHalfView:UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    let addStudentView:HomeAddView = HomeAddView(frame: .zero, kind: .student)
    let addGroupView:HomeAddView = HomeAddView(frame: .zero, kind: .group)
    
    let mainStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func setupView() {
        backgroundColor = UIColor.MyTheme.lightBG
        addGroupView.centerContainer.backgroundColor = .darkGray
        addGroupView.rightContainer.backgroundColor = .blue
        
        upperHalfStackView.addArrangedSubview(addStudentView)
        upperHalfStackView.addArrangedSubview(addGroupView)
        
        mainStackView.addArrangedSubview(upperHalfStackView)
        mainStackView.addArrangedSubview(lowerHalfView)
        
        addSubview(mainStackView)
        
        //constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: mainStackView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: mainStackView)

    }
    

}


class HomeAddView:UIView {
    
    enum StudentOrGroup:String {
        case student = "Students"
        case group = "Groups"
    }
    
    let leftContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let centerContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let rightContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let stackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    var kind:StudentOrGroup?
    
    init(frame: CGRect,kind:StudentOrGroup) {
        super.init(frame: frame)
        
        self.kind = kind
        
        setupView()
        
        switch kind {
        case .student:
            imageView.image = UIImage(named: "person")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.MyTheme.lightBlue
            imageViewTitle.textColor = UIColor.MyTheme.lightBlue
            imageViewTitle.text = StudentOrGroup.student.rawValue
        case .group:
            imageView.image = UIImage(named: "person.and.person")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor.MyTheme.lightGreen
            imageViewTitle.textColor = UIColor.MyTheme.lightGreen
            imageViewTitle.text = StudentOrGroup.group.rawValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func setupView() {
        //add to views to stuck
        setupLeftContainer()
        stackView.addArrangedSubview(leftContainer)
        stackView.addArrangedSubview(centerContainer)
        stackView.addArrangedSubview(rightContainer)
        addSubview(stackView)
        
        //constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: stackView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: stackView)
        
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let imageViewTitle:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    var padding:CGFloat  {
        if let height = UIApplication.shared.keyWindow?.screen.bounds.height {
           return CGFloat(height / 23)
        }
        return 0
    }
    
    func setupLeftContainer() {
        
        leftContainer.addSubview(imageView)
        leftContainer.addSubview(imageViewTitle)
        
        print("Padding:\(padding)")
        leftContainer.addConstraintsWithFormat(format: "H:|-\(padding)-[v0]-\(padding)-|", views: imageView)
        leftContainer.addConstraintsWithFormat(format: "H:|[v0]|", views: imageViewTitle)
        leftContainer.addConstraintsWithFormat(format: "V:|-\(padding)-[v0(\(padding))][v1]-\(padding)-|", views: imageView,imageViewTitle)
        
    }
    
    
}
