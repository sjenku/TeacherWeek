//
//  NewStudentCollectionVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewStudentCollectionVC:UIViewController {
    
    //MARK: - Properties
    let doneButton:ChooseLabelDoneBTView = {
        let bt = ChooseLabelDoneBTView(title:"Done",backgroundColor:UIColor.MyTheme.darkGreen,tintColor:UIColor.MyTheme.titleGreen)
        bt.button.addTarget(self, action: #selector(handleDoneButtonPressed), for: .touchUpInside)
        return bt
    }()

    enum textFieldTags:Int {
        case firstNameTag = 1,lastNameTag,phoneNumberTag,eMailTag
    }
    
    let firstName:TitleAndTextFieldView = {
        let view = TitleAndTextFieldView()
        view.title.text = "First Name"
        view.textField.tag = textFieldTags.firstNameTag.rawValue
        view.placeHolder = "Jhon..."
        return view
    }()
    
    let lastName:TitleAndTextFieldView = {
         let view = TitleAndTextFieldView()
         view.title.text = "Last Name"
         view.textField.tag = textFieldTags.lastNameTag.rawValue
         view.placeHolder = "Smith..."
         return view
     }()
    
    let phoneNumber:TitleAndTextFieldView = {
         let view = TitleAndTextFieldView()
         view.title.text = "Phone Number"
        view.textField.tag = textFieldTags.phoneNumberTag.rawValue
         view.placeHolder = "+543-12345678..."
         return view
     }()
    
    let eMail:TitleAndTextFieldView = {
         let view = TitleAndTextFieldView()
         view.title.text = "E-Mail"
         view.textField.tag = textFieldTags.eMailTag.rawValue
         view.placeHolder = "abc@defg.com..."
         return view
     }()
    
    lazy var stackView:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.firstName,self.lastName,self.phoneNumber,self.eMail])
        sv.distribution = .fillEqually
        sv.spacing = DeviceConfigurations.windowHeight / 30
        sv.axis = .vertical
        return sv
    }()
    
    let circleStudentIcon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "circle.person")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        view.addSubview(circleStudentIcon)
        view.addSubview(stackView)
        view.addSubview(doneButton)
        navigationController?.topViewController?.navigationItem.largeTitleDisplayMode = .never
        setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    //MARK: - Private Methods
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: circleStudentIcon)
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: stackView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButton)
        view.addConstraintsWithFormat(format: "V:[v0]-8-[v1][v2]", views: circleStudentIcon,stackView,doneButton)
        
        let additionalConstraints = [
        circleStudentIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        circleStudentIcon.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        doneButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    //MARK: - Objc Methods
    @objc private func handleDoneButtonPressed() {
        if let safeFirstName = firstName.textField.textField.text,let safeLastName = lastName.textField.textField.text {
            
            if (safeFirstName != "") || (safeLastName != "") {
                 DataManager.addNewStudent(name:safeFirstName + " " +  safeLastName)
            }
        }
        navigationController?.popViewController(animated: true)
    }

}

