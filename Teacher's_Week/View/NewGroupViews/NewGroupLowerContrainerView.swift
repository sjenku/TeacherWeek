//
//  NewGroupLowerContrainerView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 24/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit



class NewGroupLowerContrainerView:CustomView {
    
    //MARK: - Views
    
    lazy var collectionView:UICollectionView = {
        [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionV = UICollectionView(frame:.zero,collectionViewLayout:layout)
        collectionV.backgroundColor = UIColor.MyTheme.darkBG
        collectionV.register(NewGroupStudentCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionV.register(DumbHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: self.headerId)
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()

    
    let doneButton:ChooseLabelDoneBTView = {
        let button = ChooseLabelDoneBTView(title:"Done",backgroundColor:UIColor.MyTheme.darkGreen,tintColor:UIColor.MyTheme.titleGreen)
        return button
    }()
    
    //MARK: - Properties
    
    private let headerId:String = "headerId"
    private let cellId:String = "cellId"
    var info:[Student] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Overrides
    
    override func setupView() {
        super.setupView()
        
     setSubViews()
     setConstraints()
    }
    
    
    //MARK: - Private Functions
    
    private func setSubViews() {
        addSubview(collectionView)
        addSubview(doneButton)
    }
    
    private func setConstraints() {
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: doneButton)
        addConstraintsWithFormat(format: "V:|[v0]-[v1]|", views: collectionView,doneButton)
        doneButton.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.1).isActive = true
        
    }
    
}


//MARK: - UICollectionViewDataSource

extension NewGroupLowerContrainerView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewGroupStudentCell
        cell.fullNameTitle.text = info[indexPath.row].firstName + " " + info[indexPath.row].lastName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension NewGroupLowerContrainerView:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.6, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 20,height: collectionView.frame.height)
    }
}

//MARK: - UICollectionViewDelegate

extension NewGroupLowerContrainerView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
          if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
             collectionView.deselectItem(at: indexPath, animated: true)
             return false
         }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
         return true
    }
    
}

