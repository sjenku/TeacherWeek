//
//  ChooseCollectionListView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionListView: UIView {
    
    private let cellId = "cellId"
    
    private let tempararyStudentsName:[String] = ["Jennifer Lopez","Mark Tzugenberg","Tomas Adison","April Levin","Messi","Arnold Shvartsneger" ]
    
    
    
    let shadowView:UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .zero
        return view
    }()
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.MyTheme.lightBG
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        collectionView.register(ChooseCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    private func setView() {
        backgroundColor = UIColor.MyTheme.lightBG
        addSubview(shadowView)
        shadowView.addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: shadowView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: shadowView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}





extension ChooseCollectionListView:UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempararyStudentsName.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChooseCollectionViewCell
        cell.personNameLabel.text = tempararyStudentsName[indexPath.item]
        return cell
    }

}


extension ChooseCollectionListView:UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}


