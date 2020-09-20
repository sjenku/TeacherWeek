//
//  PopUpViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 20/09/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class PopUpViewController:UIViewController {
    
    
    weak var delegate:Reloader?
    
    var contentView:SliderView! = nil
    
    private lazy var doneButton:GenerateSOTitleBTView = {
          let button = GenerateSOTitleBTView(title: "Done", backgroundColor: UIColor.MyTheme.darkGreen, tintColor: UIColor.MyTheme.titleGreen)
        button.button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG.withAlphaComponent(0.4)
        setSubviews()
        setConstraints()
    }
    
    @objc func handleTap() {
        delegate?.reload()
        dismiss(animated: true, completion: nil)
    }
    
    private func setSubviews() {
        view.addSubview(contentView)
        view.addSubview(doneButton)
    }
    
    private func setConstraints() {
        let constraints:[NSLayoutConstraint] = [
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            
            doneButton.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
