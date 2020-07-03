//
//  NewGroupUpperContrainerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit




class NewGroupUpperContrainerView:CustomView {
    
    //MARK: - Views

    lazy var textField:CustomTextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let addButton:RoundButtonWithIcon = {
        let button = RoundButtonWithIcon()
        let image = UIImage(named: "studentAdd")?.withRenderingMode(.alwaysTemplate)

        button.btImageView.image = image
        button.btImageView.tintColor = UIColor.MyTheme.shadowGreen
        button.btImageView.contentMode = .scaleAspectFit
        button.shadowColor = UIColor.MyTheme.shadowGreen
        button.isHighlightedColor = UIColor.MyTheme.shadowGreen.highlight

        return button
    }()


    let deleteButton:RoundButtonWithIcon = {
           let button = RoundButtonWithIcon()
           let image = UIImage(named: "student.delete")?.withRenderingMode(.alwaysTemplate)

           button.btImageView.image = image
           button.btImageView.tintColor = .red
           button.btImageView.contentMode = .scaleAspectFit
           button.shadowColor = .red
           button.isHighlightedColor = UIColor.red.highlight

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
    
    let groupImageIcon:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "groupGreen")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.MyTheme.lightBlue
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Group Name"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 40, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Overrides
    override func setupView() {
        backgroundColor = UIColor.MyTheme.darkBG
        addSubview(textField)
        addSubview(stackView)
        addSubview(groupImageIcon)
        addSubview(title)
        setConstraints()
        handleKeyboard()
    }
    
    //MARK: - KeyBoard
    
    private func handleKeyboard() {
          let tap = UITapGestureRecognizer(target: self, action: #selector(endKeyBoardEditing))
          addGestureRecognizer(tap)
      }

      @objc private func endKeyBoardEditing() {
          endEditing(true)
      }
      
    //MARK: - Constraints
    
    
    private func setConstraints() {
        
      let constraints = [
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75, constant: 0),
        textField.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.05),
        
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.75,constant: 0),
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 24),
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -24),
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        groupImageIcon.topAnchor.constraint(equalTo: self.topAnchor,constant: DeviceConfigurations.windowHeight / 14),
        groupImageIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        groupImageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        groupImageIcon.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 12),
        
        title.topAnchor.constraint(equalTo: groupImageIcon.bottomAnchor,constant: 8),
        title.leadingAnchor.constraint(equalTo: groupImageIcon.leadingAnchor),
        title.trailingAnchor.constraint(equalTo: groupImageIcon.trailingAnchor),
        title.bottomAnchor.constraint(equalTo: textField.topAnchor,constant: -DeviceConfigurations.windowHeight / 62)
        
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}

