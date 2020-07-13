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
        l.textAlignment = .center
        l.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setSubviews()
        setConstraints()
    }
    
    private func setSubviews() {
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
        label.center = contentView.center
    }
    
}
