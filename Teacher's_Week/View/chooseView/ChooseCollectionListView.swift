//
//  ChooseCollectionListView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionListView: UIView {
    
    
 //MARK:- Overrides Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        collectionView.register(ChooseCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 //MARK:- Views And Methods Related To Views
    
    private let cellId = "cellId"
    private var students:[Student] = [
         Student(name: "Jennifer Lopez"),
         Student(name:"Mark Tzugenberg"),
         Student(name: "Tomas Adison"),
         Student(name: "April Levin"),
         Student(name: "Messi"),
         Student(name: "Arnold Shvartsneger")
    ]
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 15
        collectionView.delaysContentTouches = false
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

extension ChooseCollectionListView:UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChooseCollectionViewCell
        cell.personNameLabel.text = students[indexPath.item].name
        cell.isChecked = students[indexPath.item].checked
        return cell
    }

}


//MARK:- UICollectionViewDelegateFlowLayout

extension ChooseCollectionListView:UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}


//MARK:- UICollectionViewDelegate

extension ChooseCollectionListView:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        students[indexPath.item].checked = !students[indexPath.item].checked
//        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.purple
        
        collectionView.reloadData()
        
    }
    
}


