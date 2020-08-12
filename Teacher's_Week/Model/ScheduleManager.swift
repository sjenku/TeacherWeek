//
//  ScheduleManager.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 11/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


class ScheduleManager {
    
    static var students:[Student] = [] {
        didSet {
            //send notification
            let notificationName = NotificationKeys.keyName(key: .updateStudentSchedule)
            NotificationCenter.default.post(name: notificationName , object: nil)
        }
    }
    static var groups:[Group] = [] {
        didSet {
            //send notification
            let notificationName = NotificationKeys.keyName(key: .updateGroupSchedule)
            NotificationCenter.default.post(name: notificationName , object: nil)
        }
    }
    
}
