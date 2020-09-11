//
//  ProfileVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 10/09/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ProfileVC:UIViewController {
    
     lazy var collectionView:UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.backgroundColor = UIColor.MyTheme.lightBG
         return collectionView
     }()
    
    let profileImageNameContentView:UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    let cellIdInfo = "cellIdInfo"
    let cellIdDetail = "cellIdDetail"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        navigationController?.navigationBar.isHidden = false
        title = "Profile"
        
        collectionView.register(ListViewCellDetail.self, forCellWithReuseIdentifier: cellIdInfo) //Info
        collectionView.register(ListViewCellSubtitleDetail.self, forCellWithReuseIdentifier: cellIdDetail)
        collectionView.register(ListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        setSubviews()
        setConstraints()
        
    }
    
    
    private func setSubviews() {
        view.addSubview(profileImageNameContentView)
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: profileImageNameContentView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        let constraints:[NSLayoutConstraint] = [
            profileImageNameContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageNameContentView.heightAnchor.constraint(equalToConstant: DeviceConfigurations.windowHeight * 0.2),
            
            collectionView.topAnchor.constraint(equalTo: profileImageNameContentView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
       }
}

    

//MARK: - Extension UICollectionViewDelegateFlowLayout
extension ProfileVC:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight:CGFloat = indexPath.section == 0 ? 50 : 65
           return CGSize(width: collectionView.frame.width, height: cellHeight)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: 30)
       }
}

//MARK: - Extension UICollectionViewDataSource
extension ProfileVC:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ListHeaderView
        headerCell.backgroundColor = .blue
        headerCell.labelView.text = "hello"
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdInfo, for: indexPath)
        return cell
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListViewCellSubtitle
//             let cellInfo = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item]
//             cell.delegate = self
//             cell.title.text = cellInfo?.title
//             cell.subTitle.text = cellInfo?.subtitle
//             if isSelectable {
//                 cell.isAccessoryShown = cellInfo?.isAccessory ?? false
//             }
    }
    
    
}
