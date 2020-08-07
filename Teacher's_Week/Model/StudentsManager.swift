//
//  Students.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 22/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


struct Student {
    
    init(firstName:String = "",lastName:String = "" ,phoneNumber:String = "",eMail:String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.eMail = eMail
    }
    
    var firstName:String = ""
    var lastName:String = ""
    var eMail:String = ""
    var phoneNumber:String = ""
    var checked:Bool = false
}


