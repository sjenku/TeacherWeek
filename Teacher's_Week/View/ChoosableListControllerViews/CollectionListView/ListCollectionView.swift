//
//  ListCollectionView.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit

class ListCollectionView: CustomListView {
    
    override func setView(style:CellStyle) {
        super.setView(style: style)
        
        collectionView.layer.cornerRadius = 15
        
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        
    }
    
}
