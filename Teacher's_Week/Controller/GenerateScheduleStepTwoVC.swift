//
//  GenerateScheduleStepTwoVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class GenerateScheduleStepTwoVC:UIViewController {

   private let buttonsContainer:GenerateStepTwoButtonsContainer = {
        let container = GenerateStepTwoButtonsContainer()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
   private lazy var listView:ListCollectionView = {
        let view = ListCollectionView(frame:.zero,info:nil,style: .title)
        view.selectionActionDelegate = self
        return view
    }()
    
   private lazy var segmentView:UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.MyTheme.darkBG], for: .selected)
        segment.tintColor = .white
        segment.insertSegment(withTitle: "Students", at: 0, animated: true)
        segment.insertSegment(withTitle: "Groups", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handleSegmentValueChanged), for: .valueChanged)
        
        return segment
    }()
    
   private let instructionsView:UITextView = {
        let view = UITextView()
        view.text = "1.add requiments for each student/group\n\n2.press on \"Generate\" button,and 'Teacher's Week' will make all the calculations for you"
        view.font = UIFont.systemFont(ofSize: DeviceConfigurations.windowHeight / 50)
        view.isScrollEnabled = false
        view.isEditable = false
        view.textColor = .lightGray
        view.backgroundColor = UIColor.MyTheme.darkBG
        return view
    }()
    
    var state:StudentOrGroup?
    var selectedIndex:IndexPath?
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        setInfoDependingOnSegmentIndex()
        setSubviews()
        setConstraints()
        
    }
    
    //MARK: - OBJC Methods
    @objc private func handleSegmentValueChanged() {
        setInfoDependingOnSegmentIndex()
    }
    
    //MARK: - Private Methods
    
    private func setInfoDependingOnSegmentIndex() {
        state = segmentView.selectedSegmentIndex == 0 ? .student : .group
        let sectionsInfo:[SectionInfo] =  ScheduleManager.sectionInfoFor(state!)
        listView.updateInfo(sectionsInfo)
    }
    
    private func setSubviews() {
        view.addSubview(buttonsContainer)
        view.addSubview(instructionsView)
        view.addSubview(segmentView)
        view.addSubview(listView)
    }
    
    private func setConstraints() {
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: buttonsContainer)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: listView)
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: segmentView)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: instructionsView)

        
        let additionalConstraints = [
            buttonsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            buttonsContainer.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.2),
            
            instructionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            instructionsView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 6),
            
            segmentView.topAnchor.constraint(equalTo: instructionsView.bottomAnchor,constant: 8),
//            segmentView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight / 25),
            
            listView.topAnchor.constraint(equalTo: segmentView.bottomAnchor,constant: 16),
            listView.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor)
        ]
        
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}


extension GenerateScheduleStepTwoVC:SelectableCellActionDelegate {
    func performSelectionOfCellAction(indexPath:IndexPath) {
        selectedIndex = indexPath
       let vc = ScrollVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension GenerateScheduleStepTwoVC:DataSourceScrollVC {
    func scrollVC(data: ScrollVCData) {
        guard let _ = selectedIndex else {return}
        switch state {
        case .student:
            ScheduleManager.students[selectedIndex!.row].scheduleRequements = data
        case .group:
            ScheduleManager.groups[selectedIndex!.row].scheduleRequements = data
        case .none:
            print("None state in GenerateScheduleStepTwoVC")
        }
        selectedIndex = nil
    }
}
