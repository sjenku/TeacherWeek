//
//  ScrollVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 13/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ScrollVC:UIViewController {
    
    //MARK: - Properties
    
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
    
    private let needBreaksSwitcher:TitleAndSwitchView = {
        let view = TitleAndSwitchView()
        return view
    }()
    
    private let maxNumberOfLessonsWithoutBreaksTitle:ScrollVCTitleLabel = {
        let label = ScrollVCTitleLabel(text: "maximum number of\n lessons without breaks")
        label.numberOfLines = 0
        return label
    }()
    
    private let maxNumOfLessonsWithoutBreaksStepper:StepperWithCounter = {
        let stepperView = StepperWithCounter()
        stepperView.setSubviewsEnable(false)
        return stepperView
    }()
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        
        setSubviews()
        setConstraints()
    }
    
    //MARK: - Private Methods
    private func setSubviews() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headIcon)
        contentView.addSubview(headTitle)
        contentView.addSubview(numberOfLessonsTitle)
        contentView.addSubview(numberOfLessonsStepper)
        contentView.addSubview(lessonDurationTitle)
        contentView.addSubview(lessonDurationView)
        contentView.addSubview(needBreaksSwitcher)
        contentView.addSubview(maxNumberOfLessonsWithoutBreaksTitle)
        contentView.addSubview(maxNumOfLessonsWithoutBreaksStepper)
        
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
       
        
       let views = [headIcon,headTitle,numberOfLessonsTitle,
                    numberOfLessonsStepper,lessonDurationTitle,
                    lessonDurationView,needBreaksSwitcher,
                    maxNumberOfLessonsWithoutBreaksTitle,maxNumOfLessonsWithoutBreaksStepper]
        
        views.forEach {view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0)}
        
        
        let additionalConstraints = [
            headIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 50),
            headIcon.heightAnchor.constraint(equalToConstant: 100),
            
            headTitle.topAnchor.constraint(equalTo: headIcon.bottomAnchor,constant: 4),
            numberOfLessonsTitle.topAnchor.constraint(equalTo: headTitle.bottomAnchor,constant: 26),
            
            numberOfLessonsStepper.topAnchor.constraint(equalTo: numberOfLessonsTitle.bottomAnchor,constant: 6),
            numberOfLessonsStepper.heightAnchor.constraint(equalToConstant: 125),
            
            lessonDurationTitle.topAnchor.constraint(equalTo: numberOfLessonsStepper.bottomAnchor,constant: 2),
            
            lessonDurationView.topAnchor.constraint(equalTo: lessonDurationTitle.bottomAnchor,constant: 6),
            lessonDurationView.heightAnchor.constraint(equalToConstant: 185),
            
            needBreaksSwitcher.topAnchor.constraint(equalTo: lessonDurationView.bottomAnchor,constant: 2),
            needBreaksSwitcher.heightAnchor.constraint(equalToConstant: 45),
            
            maxNumberOfLessonsWithoutBreaksTitle.topAnchor.constraint(equalTo: needBreaksSwitcher.bottomAnchor,constant: 12),
            
            maxNumOfLessonsWithoutBreaksStepper.topAnchor.constraint(equalTo: maxNumberOfLessonsWithoutBreaksTitle.bottomAnchor,constant: 12),
            maxNumOfLessonsWithoutBreaksStepper.heightAnchor.constraint(equalToConstant: 125)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
    
}
