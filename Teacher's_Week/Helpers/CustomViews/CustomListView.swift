//
//  CustomListView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class CustomListView: UIView {
    
    
//MARK: - PrivateProperties
    private let cellId = "cellId"
    private let headerId = "headerId"
    private var cellHeight:CGFloat = 0
    private var style:CellStyle?
    
    private var sectionsInfo:[SectionInfo]?
    
//MARK:- Overrides Methods
    
    init(frame:CGRect,info:[SectionInfo]?,style:CellStyle?) {
        super.init(frame: frame)
        
        //View
        let safeStyle:CellStyle = style ?? .title
        setView(style: safeStyle)
    
        //SetProperties In Class
        self.style = safeStyle
        
        //Register
        switch safeStyle {
          case .title:
            collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: cellId)
          case .subtitle:
            collectionView.register(ListViewCellSubtitle.self, forCellWithReuseIdentifier: cellId)
        }
        collectionView.register(ListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //Info
        sectionsInfo = info
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Public Methods
    public func updateInfo(_ info:[SectionInfo]?) {
        sectionsInfo = info
        self.collectionView.reloadData()
    }
    
//MARK:- Views And Methods Related To Views
    
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.MyTheme.lightBG
        return collectionView
    }()
    
    func setView(style:CellStyle) {
        
        //background
        backgroundColor = UIColor.MyTheme.lightBG
        
        //subViews
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //cellHeight
        cellHeight = style == .title ? 45 : 60
        
        
    }
    
}


//MARK:- UICollectionViewDataSource

extension CustomListView:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsInfo?[section].cellsInfo.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if style == .title {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListViewCell
            let cellInfo = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item]
            cell.title.text = cellInfo?.title
            cell.isAccessoryShown = cellInfo?.isAccessory ?? false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListViewCellSubtitle
            let cellInfo = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item]
            cell.title.text = cellInfo?.title
            cell.subTitle.text = cellInfo?.subtitle
            cell.isAccessoryShown = cellInfo?.isAccessory ?? false
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ListHeaderView
        header.labelView.text = sectionsInfo?[indexPath.section].headerTitle
        return header
    }
    
}


//MARK:- UICollectionViewDelegateFlowLayout

extension CustomListView:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}


//MARK:- UICollectionViewDelegate

extension CustomListView:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let _ = sectionsInfo?[indexPath.section].cellsInfo[indexPath.item].isAccessory else {return}
        
        sectionsInfo![indexPath.section].cellsInfo[indexPath.item].isAccessory = !sectionsInfo![indexPath.section].cellsInfo[indexPath.item].isAccessory!
        
        collectionView.reloadData()
        
    }
    
}


