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
        collectionV.backgroundColor = .brown
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionV.register(DumbHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: self.headerId)
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()

    
    private let doneButton:ChooseLabelDoneBTView = {
        let button = ChooseLabelDoneBTView()
        return button
    }()
    
    //MARK: - Properties
    
    private let headerId:String = "headerId"
    private let cellId:String = "cellId"
    
    
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
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
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



class NewGroupStudentCell:CustomCollectionViewCell {
    
    
    
}


class DumbHeader:UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = .cyan
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
