//
//  ScrollVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 13/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ScrollVC:UIViewController {
    
   private lazy var contentSize = CGSize(width: self.view.frame.width, height: 1450)
    
   private lazy var scrollView:UIScrollView = {
        [unowned self] in
        let sv = UIScrollView(frame: self.view.frame)
        sv.contentSize = self.contentSize
        return sv
    }()
    
   private lazy var contentView:UIView = {
        [unowned self] in
        let view = UIView(frame: .zero)
        view.frame.size = self.contentSize
        return view
    }()
    
   private let headTitle:UILabel = {
        let l = UILabel()
        l.text = "Adam Ambroson"
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        l.textAlignment = .center
        return l
    }()
    
   private let headIcon:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "circle.person")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv   
    }()
    
   private let numberOfLessonsTitle:UILabel = {
        let l = UILabel()
        l.text = "Number Of Lessons Need"
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    
   private let numberOfLessonsStepper:StepperWithCounter = {
        let view = StepperWithCounter()
        return view
    }()
    
    private let lessonDurationTitle:ScrollVCTitleLabel = ScrollVCTitleLabel(text:"Duration Of Each Lesson")
 
    
    private let lessonDurationView:LessonDurationView = {
        let view = LessonDurationView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headIcon)
        contentView.addSubview(headTitle)
        contentView.addSubview(numberOfLessonsTitle)
        contentView.addSubview(numberOfLessonsStepper)
        contentView.addSubview(lessonDurationTitle)
        contentView.addSubview(lessonDurationView)
        
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
       
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: headIcon)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: headTitle)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: numberOfLessonsTitle)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: numberOfLessonsStepper)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lessonDurationTitle)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lessonDurationView)
        
        let additionalConstraints = [
            headIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 50),
            headIcon.heightAnchor.constraint(equalToConstant: 100),
            
            headTitle.topAnchor.constraint(equalTo: headIcon.bottomAnchor,constant: 4),
            numberOfLessonsTitle.topAnchor.constraint(equalTo: headTitle.bottomAnchor,constant: 26),
            
            numberOfLessonsStepper.topAnchor.constraint(equalTo: numberOfLessonsTitle.bottomAnchor,constant: 6),
            numberOfLessonsStepper.heightAnchor.constraint(equalToConstant: 125),
            
            lessonDurationTitle.topAnchor.constraint(equalTo: numberOfLessonsStepper.bottomAnchor,constant: 2),
            
            lessonDurationView.topAnchor.constraint(equalTo: lessonDurationTitle.bottomAnchor,constant: 6),
            lessonDurationView.heightAnchor.constraint(equalToConstant: 185)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
