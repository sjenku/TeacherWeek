//
//  CellInfo.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


struct CellInfo {
    
    let title:String?
    let subtitle:String?
    var isAccessory:Bool?
    var relatedTo:Any?
    
}

struct SectionInfo {
    
    let headerTitle:String
    var cellsInfo:[CellInfo]
    
    
}
