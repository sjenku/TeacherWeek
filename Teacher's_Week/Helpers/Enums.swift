//
//  Enums.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


enum StudentOrGroup:String {
    case student = "Students"
    case group = "Groups"
}


enum CellStyle {
    case title
    case subtitle
    case detailTitle
    case detailSubtitle
    case setted
}


enum Day:Int {
    case sunday = 0,monday,tuesday,wednesday,thursday,friday,saturday,none
}
