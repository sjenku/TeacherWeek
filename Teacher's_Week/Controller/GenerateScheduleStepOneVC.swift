//
//  GenerateScheduleStepOneVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 05/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class GenerateScheduleStepOneVC:UIViewController {
    
    
    private lazy var buttonsContainer:GenerateStepOneButtonsContainer = {
        let view = GenerateStepOneButtonsContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nextButton.button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        view.backgroundColor = UIColor.MyTheme.lightBG
        return view
    }()
    

    @objc private func handleNextButton() {
        let vc = GenerateScheduleStepTwoVC()
        vc.title = "Step 2/2"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    let infoContainer:GenerateStepOneInfoContainer = {
        let view = GenerateStepOneInfoContainer()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Step 1/2"
        view.backgroundColor = UIColor.MyTheme.darkBG
        setSubviews()
        setConstriants()
        setInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    //MARK: - Private Methods
    private func setInfo() {
        infoContainer.studentsInfoView.numberLabel.text = String(ScheduleManager.students.count)
        infoContainer.groupsInfoView.numberLabel.text = String(ScheduleManager.groups.count)
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
        view.addSubview(infoContainer)
    }
    
    private func setConstriants() {
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsContainer)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: infoContainer)
        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.55),
            
            infoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
