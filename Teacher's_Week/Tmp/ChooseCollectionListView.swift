//
//  ChooseCollectionListView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 17/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ChooseCollectionListView: UIView {
    
    
 //MARK: - PrivateProperties
    private let cellId = "cellId"
    private let headerId = "headerId"
    private var contacts:[Character:[Student]] = [
        "A":[Student(name: "April Levin"),Student(name: "Arnold Shvartsneger")],
        "B":[Student(name: "Bob Marli"),Student(name: "Bon Jovi"),Student(name: "Ben Gurion")],
        "C":[Student(name: "Chris Brawn")],
        "M":[Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
    ]
    lazy var letters: [Character] = {
        var l = [Character]()
        l = self.contacts.map { (name) -> Character in
            return name.key
        }
        l.sort()
        return l
    }()


    
 //MARK:- Overrides Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        collectionView.register(ChooseCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ChooseCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 //MARK:- Views And Methods Related To Views
    
    
//
//    private var students:[Student] = [
//         Student(name: "Jennifer Lopez"),
//         Student(name:"Mark Tzugenberg"),
//         Student(name: "Tomas Adison"),
//         Student(name: "April Levin"),
//         Student(name: "Messi"),
//         Student(name: "Arnold Shvartsneger")
//    ]
//
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

extension ChooseCollectionListView:UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(letters.count)
        return letters.count
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let students = contacts[letters[section]]
        return students?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChooseCollectionViewCell
        let students =  contacts[letters[indexPath.section]]
        let student = students?[indexPath.item]
        cell.title.text = student?.name ?? ""
        cell.isAccessoryShown = student?.checked ?? false
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ChooseCollectionHeaderView
        header.labelView.text = String(letters[indexPath.section])
        return header
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}


//MARK:- UICollectionViewDelegate

extension ChooseCollectionListView:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        contacts[letters[indexPath.section]]![indexPath.item].checked = !contacts[letters[indexPath.section]]![indexPath.item].checked
        
        collectionView.reloadData()
        
    }
    
}


