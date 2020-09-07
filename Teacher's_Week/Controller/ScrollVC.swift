//
//  ScrollVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 13/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

protocol DataSourceScrollVC:class {
    func scrollVC(data:ScrollVCData)
}

protocol SwitchControllerDelegate:class {
    func switchController(isOn:Bool)
}

class ScrollVC:UIViewController {
    
    //MARK: - Properties
   
   weak var delegateDataSource:DataSourceScrollVC?
   var data:ScrollVCData?
    
    private var avaiableAt:[AvaiableAt] = [] {
        willSet {
            let cellsInfo = newValue.map { (avaiableAt) -> CellInfo in
                let subtitle = avaiableAt.from.toString + " - " + avaiableAt.to.toString
               return CellInfo(title: Days[avaiableAt.day.rawValue], subtitle: subtitle, isAccessory: nil, relatedTo: avaiableAt)
            }
            let sectionInfo = SectionInfo(headerTitle: "", cellsInfo: cellsInfo)
            manageListLessonsView.listOfLessons.updateInfo([sectionInfo])
        }
    }
   private lazy var contentSize = CGSize(width: self.view.frame.width, height: 1710) //1510
    
   private lazy var scrollView:UIScrollView = {
        [unowned self] in
        let sv = UIScrollView(frame: .zero)
        sv.contentSize = self.contentSize
        sv.delaysContentTouches = false
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
        l.text = ""
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
        l.text = "Number of lessons need"
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    
   private let numberOfLessonsStepper:StepperWithCounter = {
        let view = StepperWithCounter()
        return view
    }()
    
    private let lessonDurationTitle:ScrollVCTitleLabel = ScrollVCTitleLabel(text:"Duration of each lesson")
 
    
    private let lessonDurationView:SliderView = {
        let view = SliderView(startValue: 45, maxValue: 180, sign: "min")
        return view
    }()
    
    private lazy var needBreaksSwitcher:TitleAndSwitchView = {
        let view = TitleAndSwitchView()
        view.delegate = self
        return view
    }()
    
    private let maxNumberOfLessonsWithoutBreaksTitle:ScrollVCTitleLabel = {
        let label = ScrollVCTitleLabel(text: "Maximum number of\n lessons without breaks")
        label.numberOfLines = 0
        return label
    }()
    
    private let maxNumOfLessonsWithoutBreaksStepper:StepperWithCounter = {
        let stepperView = StepperWithCounter()
        stepperView.setSubviewsEnable(false)
        return stepperView
    }()
    
       private let breaksDurationTitle:ScrollVCTitleLabel = ScrollVCTitleLabel(text:"Duration of each break")
    
       
       private let breaksDurationView:SliderView = {
        let view = SliderView(startValue: 10, maxValue: 180, sign: "min")
        view.isEnable = false
           return view
       }()
    
    private let paymentPerLessonTitle:ScrollVCTitleLabel = ScrollVCTitleLabel(text: "Payment per lesson")
    
    private let paymentPerLessonView:SliderView = {
          let stepperView = SliderView(startValue: 50, maxValue: 500, sign: "$")
          return stepperView
      }()
    
    private let availableAtTitle:UILabel = {
        let label = UILabel()
        label.text = "Available at"
        label.textColor = UIColor.MyTheme.lightBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        return label
    }()
    
    private lazy var manageListLessonsView:ManageListLessonsView = {
        let view = ManageListLessonsView()
        view.addButton.button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        view.doneButton.button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        //TODO:Fix so many dependicies                                                                                                      // addbutton->button and so on
        return view
    }()
    
    //MARK: - OBJC Methods
    
    @objc func addButtonPressed() {
        let vc = TimePickerVC(style: .dayStyle)
        vc.senderViewController = self
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doneButtonPressed() {
        delegateDataSource?.scrollVC(data: ScrollVCData(numberOfLessonsNeed: numberOfLessonsStepper.currentValue, durationOfEachLessonMin: lessonDurationView.currentValue, needBreaks: needBreaksSwitcher.currentValue, maxNumOfLessonsWithoutBreaks: maxNumOfLessonsWithoutBreaksStepper.currentValue, paymentPerLesson: paymentPerLessonView.currentValue, timeBreak: breaksDurationView.currentValue, avaiablesAt: avaiableAt))
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Init & Deinit
    init(title:String,data:ScrollVCData?) {
        super.init(nibName: nil, bundle: nil)
        
        headTitle.text = title
        self.data = data
        print("Init")
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
           print("Deinit ScrollVC")
       }
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        view.backgroundColor = UIColor.MyTheme.darkBG
        
        setSubviews()
        setConstraints()
        setDataForScrollVC()
    }
    
    //MARK: - Private Methods
    private func setDataForScrollVC() {
        if let safeData = data {
            numberOfLessonsStepper.currentValue = safeData.numberOfLessonsNeed
            lessonDurationView.currentValue = safeData.durationOfEachLessonMin
            needBreaksSwitcher.currentValue = safeData.needBreaks
            maxNumOfLessonsWithoutBreaksStepper.currentValue = safeData.maxNumOfLessonsWithoutBreaks
            maxNumOfLessonsWithoutBreaksStepper.setSubviewsEnable(safeData.needBreaks)
            breaksDurationView.isEnable = safeData.needBreaks
            breaksDurationView.currentValue = safeData.timeBreak
            paymentPerLessonView.currentValue = safeData.paymentPerLesson
            avaiableAt = safeData.avaiablesAt
        }
    }
    
    private func setSubviews() {
        scrollView.addSubview(contentView)
        
        let contentViews = [
        headIcon,headTitle,numberOfLessonsTitle,numberOfLessonsStepper,lessonDurationTitle,lessonDurationView,
        needBreaksSwitcher,maxNumberOfLessonsWithoutBreaksTitle,maxNumOfLessonsWithoutBreaksStepper,breaksDurationTitle,breaksDurationView,paymentPerLessonTitle,
        paymentPerLessonTitle,paymentPerLessonView,availableAtTitle,manageListLessonsView
        ]
        
        contentViews.forEach { contentView.addSubview($0) }
        
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
       
        
        let views = [scrollView,headIcon,headTitle,numberOfLessonsTitle,
                    numberOfLessonsStepper,lessonDurationTitle,
                    lessonDurationView,needBreaksSwitcher,
                    maxNumberOfLessonsWithoutBreaksTitle,
                    maxNumOfLessonsWithoutBreaksStepper,breaksDurationTitle,breaksDurationView,paymentPerLessonTitle,
                    paymentPerLessonView,availableAtTitle,manageListLessonsView]
        
        views.forEach {view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0)}
        
        
        let additionalConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 50),
            headIcon.heightAnchor.constraint(equalToConstant: 60),
            
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
            maxNumOfLessonsWithoutBreaksStepper.heightAnchor.constraint(equalToConstant: 125),
            
            breaksDurationTitle.topAnchor.constraint(equalTo: maxNumOfLessonsWithoutBreaksStepper.bottomAnchor,constant: 2),
            
            breaksDurationView.topAnchor.constraint(equalTo: breaksDurationTitle.bottomAnchor,constant: 6),
            breaksDurationView.heightAnchor.constraint(equalToConstant: 185),
            
            paymentPerLessonTitle.topAnchor.constraint(equalTo: breaksDurationView.bottomAnchor,constant: 12),
            
            paymentPerLessonView.topAnchor.constraint(equalTo: paymentPerLessonTitle.bottomAnchor,constant: 6),
            paymentPerLessonView.heightAnchor.constraint(equalToConstant: 185),
            
            availableAtTitle.topAnchor.constraint(equalTo: paymentPerLessonView.bottomAnchor,constant: 12),
            
            manageListLessonsView.topAnchor.constraint(equalTo: availableAtTitle.bottomAnchor,constant: 6),
            manageListLessonsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}

//MARK: - SwitchControllerDelegate
extension ScrollVC:SwitchControllerDelegate {
    func switchController(isOn: Bool) {
        maxNumOfLessonsWithoutBreaksStepper.setSubviewsEnable(isOn)
        breaksDurationView.isEnable = isOn
    }
}

//MARK: - TimePickerVCDelgate
extension ScrollVC:TimePickerVCDelegate {
    func timePicker(data: AvaiableAt) {
        avaiableAt.append(data)
    }
}
