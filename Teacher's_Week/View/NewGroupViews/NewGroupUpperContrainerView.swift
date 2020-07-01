//
//  NewGroupUpperContrainerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class NewGroupUpperContrainerView:CustomView {
    
    
    lazy var textField:UITextField = {
          let tv = UITextField()
          tv.backgroundColor = UIColor.MyTheme.textFieldColor
          tv.placeholder = "Your Group Name"
          tv.adjustsFontSizeToFitWidth = true
          tv.textAlignment = .center
          tv.layer.cornerRadius = 10
          tv.delegate = self
          tv.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
          tv.textColor = UIColor.darkGray
          tv.translatesAutoresizingMaskIntoConstraints = false
          return tv
      }()
    
    let addButton:RoundButtonWithIcon = {
        let button = RoundButtonWithIcon()
        let image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysTemplate)

        button.btImageView.image = image
        button.btImageView.tintColor = .green
        button.btImageView.contentMode = .scaleAspectFit
        button.shadowColor = .purple

        return button
    }()


    let deleteButton:RoundButtonWithIcon = {
           let button = RoundButtonWithIcon()
           let image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysTemplate)

           button.btImageView.image = image
           button.btImageView.tintColor = .red
           button.btImageView.contentMode = .scaleAspectFit
           button.shadowColor = .systemPink

           return button
       }()

    lazy var stackView:UIStackView = {
        [unowned self] in
        let sv = UIStackView(arrangedSubviews: [self.addButton,self.deleteButton])
        sv.distribution = .fillEqually
        sv.spacing = DeviceConfigurations.windowWidth / 4
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        }()
    
    override func setupView() {
        backgroundColor = UIColor.MyTheme.darkBG
        addSubview(textField)
        addSubview(stackView)
        setConstraints()
        handleKeyboard()
    }
    
    private func handleKeyboard() {
          let tap = UITapGestureRecognizer(target: self, action: #selector(endKeyBoardEditing))
          addGestureRecognizer(tap)
      }

      @objc private func endKeyBoardEditing() {
          endEditing(true)
      }
      

    
    private func setConstraints() {
        
      let constraints = [
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75, constant: 0),
        textField.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.05),
        
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.75,constant: 0),
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 8),
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}



extension NewGroupUpperContrainerView:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
