//
//  NotificationKeys.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 11/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


struct NotificationKeys {
    enum Keys:String {
        case updateStudentSchedule = "co.teachersWeek.updateStudentSchedule"
        case updateGroupSchedule = "co.teachersWeek.updateGroupSchedule"
    }
    
    static func keyName(key:NotificationKeys.Keys)->Notification.Name {
        return Notification.Name(rawValue: key.rawValue)
    }
}

