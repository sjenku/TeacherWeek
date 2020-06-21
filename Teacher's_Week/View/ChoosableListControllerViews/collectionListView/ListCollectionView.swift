//
//  ListCollectionView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ListCollectionView: UIView {
    
    
 //MARK: - PrivateProperties
    private let cellId = "cellId"
    private let headerId = "headerId"

    
    var sectionsInfo:[SectionInfo]?
    
 //MARK:- Overrides Methods
    
    init(frame:CGRect,info:[SectionInfo]? = nil) {
        super.init(frame: frame)
        
        setView()
        collectionView.register(ListCellSubtitle.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        sectionsInfo = info
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 //MARK:- Views And Methods Related To Views
    
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 15
        collectionView.backgroundColor = UIColor.MyTheme.lightBG
        return collectionView
    }()
    
    private func setView() {
        
        //background
        backgroundColor = UIColor.MyTheme.lightBG
        
        //layer
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        
        //subViews
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        
        
    }
    
}


//MARK:- UICollectionViewDataSource

extension ListCollectionView:UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsInfo?.count ?? 0
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsInfo?[section].cellsInfo.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListCellSubtitle
        let cellInfo = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item]
        cell.title.text = cellInfo?.title
        cell.isAccessoryShown = cellInfo?.isAccessory ?? false
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ListHeaderView
        header.labelView.text = sectionsInfo?[indexPath.section].headerTitle
        return header
    }

}


//MARK:- UICollectionViewDelegateFlowLayout

extension ListCollectionView:UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}


//MARK:- UICollectionViewDelegate

extension ListCollectionView:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let _ = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item].isAccessory else {return}
        
        sectionsInfo![indexPath.section].cellsInfo[indexPath.item].isAccessory = !sectionsInfo![indexPath.section].cellsInfo[indexPath.item].isAccessory! 

        collectionView.reloadData()
        
    }
    
}


