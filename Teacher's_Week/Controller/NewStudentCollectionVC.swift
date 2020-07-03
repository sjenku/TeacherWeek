//
//  NewStudentCollectionVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 02/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewStudentCollectionVC:UIViewController {
    
    
    let doneButton:ChooseLabelDoneBTView = {
        let bt = ChooseLabelDoneBTView()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        view.addSubview(circleStudentIcon)
        view.addSubview(stackView)
        view.addSubview(doneButton)
        setConstraints()
//        handleKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        setNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        NotificationCenter.default.removeObserver(self)
    }
    

    
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

//MARK: - KeyBoard
    
//    private func setNotifications() {
//        //KeyBoard will show
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        //KeyBoard will hide
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//
//        guard let textField = CustomTextField.currentActive else { return }
//
//        if isKeyBoardOverlappingTextField(textField: textField, keyBoardSize: keyboardSize) {
//            let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
//            print("tabbarHieght = \(tabBarHeight)")
//                self.view.frame.origin.y = 0 - keyboardSize.height + tabBarHeight
//
//
//        }
//
//    }
//
//    private func isKeyBoardOverlappingTextField(textField:UITextField,keyBoardSize:CGRect) -> Bool {
//        var fieldYPositionPlusHeight:CGFloat = 0
//        let stackViewItemHeight:CGFloat = (stackView.frame.height - (3 * stackView.spacing)) / 4
//
//        switch textField.tag {
//        case textFieldTags.firstNameTag.rawValue:
//            fieldYPositionPlusHeight = stackView.frame.origin.y + stackViewItemHeight
//
//        case textFieldTags.lastNameTag.rawValue:
//             fieldYPositionPlusHeight = stackView.frame.origin.y + stackView.spacing + stackViewItemHeight * 2
//
//        case textFieldTags.phoneNumberTag.rawValue:
//             fieldYPositionPlusHeight = stackView.frame.origin.y + (stackView.spacing * 2) + stackViewItemHeight * 3
//
//        case textFieldTags.eMailTag.rawValue:
//             fieldYPositionPlusHeight = stackView.frame.origin.y + (stackView.spacing * 3) + stackViewItemHeight * 4
//
//        default:
//            break
//        }
//
//        let keyBoardYPosition = DeviceConfigurations.windowHeight - keyBoardSize.height
//        return fieldYPositionPlusHeight > keyBoardYPosition
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
//    }
//

    
    
    
//    private func handleKeyboard() {
//
//
//          let tap = UITapGestureRecognizer(target: self, action: #selector(endKeyBoardEditing))
//        view.addGestureRecognizer(tap)
//      }
//
//      @objc private func endKeyBoardEditing() {
//        view.endEditing(true)
//      }
    
}

