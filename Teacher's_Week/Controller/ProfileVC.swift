//
//  ProfileVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 10/09/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit
import SafariServices

protocol Reloader:NSObject {
    func reload()
}

class ProfileVC:UIViewController,Reloader {
    
    private var profileInfo:[SectionInfo] {
        get {
            return ProfileModel.getInfo()
        }
    }
    
     lazy var collectionView:UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.backgroundColor = UIColor.MyTheme.lightBG
         return collectionView
     }()
    
    let profileImageNameContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.darkBG
        return view
    }()
    
    let line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    
    let profileImageNameContentainerHeight:CGFloat = DeviceConfigurations.windowHeight * 0.25
    var profileImageHeight:CGFloat {
        get {return profileImageNameContentainerHeight * 0.67}
    }
    
    lazy var profileName:ScrollVCTitleLabel = {
         let name = ScrollVCTitleLabel(text: "Jekppo Fami")
         let fontSize = self.profileImageHeight * 0.3
         name.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
         return name
     }()
     
    
    lazy var profileImage:UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "profileImage"), for: .normal)
        button.layer.cornerRadius = self.profileImageHeight * 0.5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor.MyTheme.lightBlue.cgColor
        return button
    }()
    
    let editSymbol:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "editPancil"), for: .normal)
        return button
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ProfileVC Present")
    }
    
    
    private func setSubviews() {
        profileImageNameContainerView.addSubview(profileImage)
        profileImageNameContainerView.addSubview(profileName)
        profileImageNameContainerView.addSubview(editSymbol)
        
        view.addSubview(profileImageNameContainerView)
        view.addSubview(collectionView)
    }
    
    internal func reload() {
        collectionView.reloadData()
        print("Reloaded")
    }
    
    private func setConstraints() {
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: profileImageNameContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        
        profileImageNameContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: profileName)
        
        let constraints:[NSLayoutConstraint] = [
            profileImageNameContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageNameContainerView.heightAnchor.constraint(equalToConstant: profileImageNameContentainerHeight),
            
            collectionView.topAnchor.constraint(equalTo: profileImageNameContainerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: profileImageNameContainerView.topAnchor,constant: profileImageNameContentainerHeight * 0.05),
            profileImage.heightAnchor.constraint(equalToConstant: profileImageHeight),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            profileImage.centerXAnchor.constraint(equalTo: profileImageNameContainerView.centerXAnchor),
            
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
            profileName.bottomAnchor.constraint(equalTo: profileImageNameContainerView.bottomAnchor),
            
            editSymbol.topAnchor.constraint(equalTo: profileImageNameContainerView.topAnchor,constant: 8),
            editSymbol.leadingAnchor.constraint(equalTo: profileImageNameContainerView.leadingAnchor,constant: 8),
            editSymbol.heightAnchor.constraint(equalTo: profileImage.heightAnchor,multiplier: 0.35),
            editSymbol.widthAnchor.constraint(equalTo: editSymbol.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
       }
}

    

//MARK: - Extension UICollectionViewDelegateFlowLayout
extension ProfileVC:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight:CGFloat = indexPath.section == 0 ? 65 : 50
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
        headerCell.backgroundColor = UIColor.MyTheme.headerColor
        headerCell.labelView.text = profileInfo[indexPath.section].headerTitle
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell:ListViewCellSubtitleDetail
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdDetail, for: indexPath) as! ListViewCellSubtitleDetail
            cell.title.text = profileInfo[indexPath.section].cellsInfo[indexPath.row].title
            cell.subTitle.text = profileInfo[indexPath.section].cellsInfo[indexPath.row].subtitle
            cell.isAccessoryShown = true
            return cell
        
        case 1:
            let cell:ListViewCellDetail
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdInfo, for: indexPath) as!
               ListViewCellDetail
            cell.title.text = profileInfo[indexPath.section].cellsInfo[indexPath.row].title
            cell.isAccessoryShown = true
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension ProfileVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Selected section:\(indexPath.section) , row:\(indexPath.row)")
        doActionDependingOnSelectionWithIndexPath(indexPath)
    }
    
    
    private func openSafariPage(url:URL?) {
        guard let safeUrl = url else {return}
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: safeUrl,configuration: config)
        present(safariVC, animated: true, completion: nil)
    }
    
    private func doActionDependingOnSelectionWithIndexPath(_ indexPath:IndexPath) {
        var vc:PopUpViewController!
        switch indexPath.section {
        case 0:
            print("section 0")
            switch indexPath.row {
            case 0:
                vc = ProfilePopUpVC(changerOf: .breaksDuration)
            case 1:
                vc = ProfilePopUpVC(changerOf: .lessonDuration)
            case 2:
                vc = ProfilePopUpVC(changerOf: .lessonPrice)
            default:
                fatalError("choice can't be default")
            }
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        case 1:
            print("Section 1")
            switch indexPath.row {
            case 0: //Terms And Conditions
               openSafariPage(url: URL(string: "https://www.websitepolicies.com/policies/view/lmtJRl1K"))
            case 1: //Privacy Policy
                openSafariPage(url: URL(string: "https://www.websitepolicies.com/policies/view/WdwqiGLW"))
            case 2: //Credits
                print("Row 2")
            default:
                fatalError("choice can't be default")
            }
        default:
            fatalError()
        }
        
    }
    
}
