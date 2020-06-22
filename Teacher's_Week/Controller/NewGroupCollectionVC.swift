//
//  NewGroupViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class NewGroupCollectionVC:UICollectionViewController {
    
    
    
    let upperCellId = "upperCellId"
    let lowerCellId = "lowerCellId"
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout:layout)
        
        collectionView.backgroundColor = UIColor.MyTheme.darkBG
        collectionView.register(NewGroupLowerCell.self, forCellWithReuseIdentifier: lowerCellId)
        collectionView.register(NewGroupUpperCell.self, forCellWithReuseIdentifier: upperCellId)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = indexPath.item == 0 ? collectionView.dequeueReusableCell(withReuseIdentifier: upperCellId, for: indexPath) :
        collectionView.dequeueReusableCell(withReuseIdentifier: lowerCellId, for: indexPath)
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension NewGroupCollectionVC:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
