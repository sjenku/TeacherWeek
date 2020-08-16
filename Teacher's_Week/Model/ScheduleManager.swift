//
//  ScheduleManager.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 11/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


class ScheduleManager {
    
    static var schedules:[ScheduleResultTable] = {
        let lessons:[ScheduleLesson] = [
            ScheduleLesson(lessonHolder: "Ivanov Petrov", avaiableAt: AvaiableAt(day: .sunday,from:Date(),to:Date())),
            ScheduleLesson(lessonHolder: "Genadi Pupkin", avaiableAt: AvaiableAt(day: .sunday,from:Date()-100,to:Date())),
            ScheduleLesson(lessonHolder: "Salvator Famin", avaiableAt: AvaiableAt(day: .friday,from:Date(),to:Date()))
        ]
        let schedule = ScheduleResultTable(lessons: lessons)
        
        return [schedule]
    }()
    
    static var schedulesFromStudents:[ScheduleResultTable] {
        get {
            var scheduleLessons:[ScheduleLesson] = []
            for student in students {
                if let studentRequients = student.scheduleRequements {
                    for avaiableAt in studentRequients.avaiablesAt {
                        scheduleLessons.append(ScheduleLesson(lessonHolder: student.firstName + " " + student.lastName, avaiableAt: avaiableAt))
                    }
                }
            }
            
           return [ScheduleResultTable(lessons: scheduleLessons)]
        }
    }
    
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
    
    static func sectionInfoForScheduleResults()->[SectionInfo] {
        guard let scheudle = ScheduleManager.schedulesFromStudents.first else {return []}
        var sectionsInfo:[SectionInfo] = []
        var cellInfoRelatedToDayDict:[Day:[CellInfo]] = [:]
         scheudle.lessons.forEach { (lesson)  in
           let cellInfo = CellInfo(title: lesson.lessonHolder, subtitle: lesson.avaiableAt.from.toString + " - " + lesson.avaiableAt.to.toString, isAccessory: nil, relatedTo: lesson)
            if let _ = cellInfoRelatedToDayDict[lesson.avaiableAt.day] {
                cellInfoRelatedToDayDict[lesson.avaiableAt.day]?.append(cellInfo)
            } else {
                cellInfoRelatedToDayDict[lesson.avaiableAt.day] = [cellInfo]
            }
        }
        
      let sortedByDayCellsInfo = cellInfoRelatedToDayDict.sorted { $0.key.rawValue < $1.key.rawValue }
        
        for (day,cellsInfo) in sortedByDayCellsInfo {
            //Sort By time
            let sortedCellInfo = cellsInfo.sorted { (firstCell, secondCell) -> Bool in
                guard let lessonOne = firstCell.relatedTo as? ScheduleLesson else {return false}
                guard let lessonSecond = secondCell.relatedTo as? ScheduleLesson  else {return false}
                return lessonOne.avaiableAt.from < lessonSecond.avaiableAt.from
            }
            
            sectionsInfo.append(SectionInfo(headerTitle: Days[day.rawValue], cellsInfo: sortedCellInfo))
        }
        
        return sectionsInfo
    }
    
}
