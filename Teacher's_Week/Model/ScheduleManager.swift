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
    
    static func sectionInfoFor(_ value:StudentOrGroup)->[SectionInfo] {
        var cellsInfo:[CellInfo] = []
        switch value {
        case .student:
            cellsInfo = students.map({ (student) -> CellInfo in
                CellInfo(title: student.firstName + " " + student.lastName, subtitle: "", isAccessory: student.checked, relatedTo: student)
            })
        case .group:
            cellsInfo = groups.map({ (group) -> CellInfo in
                CellInfo(title: group.groupName, subtitle: String(group.students.count), isAccessory: group.checked, relatedTo: group)
            })
        }
        
        let sectionInfo = SectionInfo(headerTitle: "", cellsInfo: cellsInfo)
        return [sectionInfo]
    }
    
}
