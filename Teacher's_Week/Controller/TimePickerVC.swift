//
//  TimePickerVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


enum TimePickerVCStyle {
    case dayStyle,timeFromStyle,timeToStyle
}

protocol TimePickerVCDelegate:class {
    func timePicker(data:AvaiableAt)
}

class TimePickerVC:UIViewController {
    
    //MARK: - Initialization
    init(style:TimePickerVCStyle) {
        super.init(nibName: nil, bundle: nil)
        
        self.style = style
        setPickerViewWithStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    
    //MARK: - Properties
    var time:AvaiableAt?
    weak var senderViewController:UIViewController?
    weak var delegate:TimePickerVCDelegate?
    private var style:TimePickerVCStyle?
    
    
    private let headerTitles:[TimePickerVCStyle:String] = [
        TimePickerVCStyle.dayStyle : "Day For The\nLesson?" ,
        TimePickerVCStyle.timeFromStyle : "Start Time?" ,
        TimePickerVCStyle.timeToStyle : "End Time?"
    ]
    private lazy var header:UILabel = {
        let label = UILabel()
        label.text = self.headerTitles[self.style ?? TimePickerVCStyle.dayStyle]
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton:GenerateSOTitleBTView = {
           let view = GenerateSOTitleBTView(title: "Next", backgroundColor: UIColor.MyTheme.darkBlue, tintColor: UIColor.MyTheme.titleBlue)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.button.addTarget(self, action: #selector(handleNextBT), for: .touchUpInside)
           return view
       }()
    

    private let arrowPointingRight:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow.right")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let arrowPointingLeft:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow.left")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let containerForPickerView:UIView = {
        let view = UIView()
        return view
    }()
    
    private var pickerView:UIView?
    
    private lazy var dayPickerView:UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private let datePickerView:UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.timeZone = .current
        picker.setValue(UIColor.white, forKey: "textColor")
        
        return picker
    }()
    
    //MARK: - OBJC Methods
    @objc private func handleNextBT() {
        var vc:TimePickerVC?
        
        switch style {
        case .dayStyle:
            vc = TimePickerVC(style: .timeFromStyle)
            vc?.senderViewController = senderViewController
            vc?.delegate = delegate
            guard let day = Day(rawValue:dayPickerView.selectedRow(inComponent: 0)) else {return}
            vc?.time = AvaiableAt(day: day, from: Date(), to: Date())
        case .timeFromStyle:
            vc = TimePickerVC(style: .timeToStyle)
            vc?.senderViewController = senderViewController
            vc?.delegate = delegate
            if let date = datePickerView.date.zeroSeconds {
            vc?.time = AvaiableAt(day: time?.day ?? .none, from: date, to: Date())
            }
        case .timeToStyle:
            if let date = datePickerView.date.zeroSeconds {
                delegate?.timePicker(data: AvaiableAt(day: time?.day ?? .none, from: time?.from ?? Date(), to: date))
            }
            if let popToVC = senderViewController {
                navigationController?.popToViewController(popToVC, animated: true)
            } else {
                navigationController?.popToRootViewController(animated: true)
            }
            return
        case .none:
            print("None")
        }
        print("Goes Next")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //MARK: - Overrides Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstraints()
        
    }
    
    
    //MARK: - Private Functions
    
    private func setPickerViewWithStyle() {
        pickerView = style == .dayStyle ? dayPickerView : datePickerView
    }
    
    private func setSubviews() {
        
        containerForPickerView.addSubview(pickerView!)
        
        view.addSubview(header)
        view.addSubview(nextButton)
        view.addSubview(containerForPickerView)
        view.addSubview(arrowPointingRight)
        view.addSubview(arrowPointingLeft)
        
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: header)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: nextButton)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: containerForPickerView)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]", views: arrowPointingRight)
        view.addConstraintsWithFormat(format: "H:[v0]-24-|", views: arrowPointingLeft)
        
        let additionalConstraints = [
            header.bottomAnchor.constraint(equalTo: containerForPickerView.topAnchor,constant: 8),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1),
            
            containerForPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerForPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerForPickerView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 2),
            
            arrowPointingRight.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowPointingRight.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            arrowPointingRight.widthAnchor.constraint(equalTo: arrowPointingRight.heightAnchor),
            
            arrowPointingLeft.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowPointingLeft.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
            arrowPointingLeft.widthAnchor.constraint(equalTo: arrowPointingRight.heightAnchor),
            
            pickerView!.topAnchor.constraint(equalTo: containerForPickerView.topAnchor),
            pickerView!.leadingAnchor.constraint(equalTo: containerForPickerView.leadingAnchor),
            pickerView!.bottomAnchor.constraint(equalTo: containerForPickerView.bottomAnchor),
            pickerView!.trailingAnchor.constraint(equalTo: containerForPickerView.trailingAnchor)
        ]
        
        additionalConstraints.forEach {$0.isActive = true}
    }
    
    deinit {
        print("Deinit TimePickerVC")
    }
    
}

//MARK: - Extensions

extension TimePickerVC:UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return DeviceConfigurations.windowHeight / 15
    }
    
}


extension TimePickerVC:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = Days[row]
        label.textColor = UIColor.MyTheme.extraLightGray
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }
}
