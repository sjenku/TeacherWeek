//
//  ScrollVC.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 13/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


class ScrollVC:UIViewController {
    
   private lazy var contentSize = CGSize(width: self.view.frame.width, height: 1450)
    
    lazy var scrollView:UIScrollView = {
        [unowned self] in
        let sv = UIScrollView(frame: self.view.frame)
        sv.contentSize = self.contentSize
        return sv
    }()
    
    lazy var contentView:UIView = {
        [unowned self] in
        let view = UIView(frame: .zero)
        view.frame.size = self.contentSize
        return view
    }()
    
    let label:UILabel = {
        let l = UILabel()
        l.text = "Hello World"
        l.textColor = .white
        l.textAlignment = .center
        l.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        return l
    }()
    
    let headIcon:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "circle.person")?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv   
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.MyTheme.darkBG
        
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headIcon)
        
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
       
        view.addConstraintsWithFormat(format: "H:|-[v0]-|", views: headIcon)
        
        let additionalConstraints = [
            headIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 50),
            headIcon.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        additionalConstraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
