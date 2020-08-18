//
//  ScheduleManager.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 11/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


class ScheduleManager {
    
    //MARK: - Properties

    static var schedulesFromStudents:[ScheduleResultTable] {
        get {
            
            //Collect all students avaiableTimes
            var scheduleLessons:[ScheduleLesson] = []
            for student in students {
                if let studentRequients = student.scheduleRequements {
                    for avaiableAt in studentRequients.avaiablesAt {
                        scheduleLessons.append(ScheduleLesson(lessonHolder: student.firstName + " " + student.lastName, price: studentRequients.paymentPerLesson, avaiableAt: avaiableAt))
                    }
                }
            }
            
            //1.sort all lessons by finish time
            scheduleLessons.sort { (firstLesson, secondLesson) -> Bool in
                let dayTimeInterval = 60*60*24
                let firstLessonFullTimeTo = firstLesson.avaiableAt.to.addingTimeInterval(TimeInterval(dayTimeInterval * (firstLesson.avaiableAt.day.rawValue + 1)))
                let secondLessonFullTimeTo = secondLesson.avaiableAt.to.addingTimeInterval(TimeInterval(dayTimeInterval * (secondLesson.avaiableAt.day.rawValue + 1)))
                return firstLessonFullTimeTo < secondLessonFullTimeTo
            }
            //2.create array holding index of lesson that not overrlaping with current lesson
            var notConflictingIndexes:[Int] = lastNotConflictingLessons(scheduleLessons)
            print(notConflictingIndexes)
            
            //3.create recursive function 'optimal' that calculate optimal profit from lessons
            let optVal = ScheduleManager.optimal(&scheduleLessons,&notConflictingIndexes,scheduleLessons.count - 1)
            print("Optimal Profit=>\(optVal)$")
            
            //4.create function that find-solution with help of 'optimal' function
            //5.create another iterative apporach for finding optimal profit
            
            
           return [ScheduleResultTable(lessons: scheduleLessons)]
        }
    }

    fileprivate static func optimal(_ lessons:inout [ScheduleLesson],_ p:inout [Int],_ j:Int)->Int { //O(2^n) bad time complexity
        if j == -1 {
            return 0
        } else {
            return max(lessons[j].price + optimal(&lessons,&p,p[j]),optimal(&lessons,&p,j-1))
        }
    }
    
    fileprivate static func lastNotConflictingLessons(_ lessons:[ScheduleLesson])->[Int] {   //O(n^2)
        var p:Array<Int> = Array(repeating: -1, count: lessons.count)
        for (indexLesson,lesson) in lessons.enumerated() {
            for index in stride(from: indexLesson, to: -1, by: -1) {
                if(lesson.avaiableAt.fullDateFrom >= lessons[index].avaiableAt.fullDateTo) {
                    p[indexLesson] = index
                   break
                }
            }
        }
        return p
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
    
    //MARK: - Static Methods
    
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
        var cellsInfo:[CellInfo] = []
        var daysCellsArr:Array<Array<CellInfo>> = Array(repeating: [], count: 7)
        scheudle.lessons.forEach { (lesson) in
            let cellInfo = CellInfo(title: lesson.lessonHolder, subtitle: lesson.avaiableAt.from.toString + " - " + lesson.avaiableAt.to.toString, isAccessory: nil, relatedTo: lesson)
            cellsInfo.append(cellInfo)
            daysCellsArr[lesson.avaiableAt.day.rawValue].append(cellInfo)
        }
        
        
        for dayLessonCells in daysCellsArr {
            if dayLessonCells.count == 0 {continue}
            let dayTitle = Days[(dayLessonCells[0].relatedTo as! ScheduleLesson).avaiableAt.day.rawValue]
            sectionsInfo.append(SectionInfo(headerTitle:dayTitle , cellsInfo: dayLessonCells))
        }
        
        return sectionsInfo
    }
    

}



//    static func sectionInfoForScheduleResults()->[SectionInfo] {
//        guard let scheudle = ScheduleManager.schedulesFromStudents.first else {return []}
//        var sectionsInfo:[SectionInfo] = []
//        var cellInfoRelatedToDayDict:[Day:[CellInfo]] = [:]
//         scheudle.lessons.forEach { (lesson)  in
//           let cellInfo = CellInfo(title: lesson.lessonHolder, subtitle: lesson.avaiableAt.from.toString + " - " + lesson.avaiableAt.to.toString, isAccessory: nil, relatedTo: lesson)
//            if let _ = cellInfoRelatedToDayDict[lesson.avaiableAt.day] {
//                cellInfoRelatedToDayDict[lesson.avaiableAt.day]?.append(cellInfo)
//            } else {
//                cellInfoRelatedToDayDict[lesson.avaiableAt.day] = [cellInfo]
//            }
//        }
//
//      let sortedByDayCellsInfo = cellInfoRelatedToDayDict.sorted { $0.key.rawValue < $1.key.rawValue }
//
//        for (day,cellsInfo) in sortedByDayCellsInfo {
//            //Sort By time
//            let sortedCellInfo = cellsInfo.sorted { (firstCell, secondCell) -> Bool in
//                guard let lessonOne = firstCell.relatedTo as? ScheduleLesson else {return false}
//                guard let lessonSecond = secondCell.relatedTo as? ScheduleLesson  else {return false}
//                return lessonOne.avaiableAt.from < lessonSecond.avaiableAt.from
//            }
//
//            sectionsInfo.append(SectionInfo(headerTitle: Days[day.rawValue], cellsInfo: sortedCellInfo))
//        }
//
//        return sectionsInfo
//    }
    


//    static var schedules:[ScheduleResultTable] = {
//        let lessons:[ScheduleLesson] = [
//            ScheduleLesson(lessonHolder: "Ivanov Petrov", avaiableAt: AvaiableAt(day: .sunday,from:Date(),to:Date())),
//            ScheduleLesson(lessonHolder: "Genadi Pupkin", avaiableAt: AvaiableAt(day: .sunday,from:Date()-100,to:Date())),
//            ScheduleLesson(lessonHolder: "Salvator Famin", avaiableAt: AvaiableAt(day: .friday,from:Date(),to:Date()))
//        ]
//        let schedule = ScheduleResultTable(lessons: lessons)
//
//        return [schedule]
//    }()


//static var schedulesFromStudents:[ScheduleResultTable] {
//       get {
//           var scheduleLessons:[ScheduleLesson] = []
//           for student in students {
//               if let studentRequients = student.scheduleRequements {
//                   for avaiableAt in studentRequients.avaiablesAt {
//                       scheduleLessons.append(ScheduleLesson(lessonHolder: student.firstName + " " + student.lastName, avaiableAt: avaiableAt))
//                   }
//               }
//           }
//
//          return [ScheduleResultTable(lessons: scheduleLessons)]
//       }
//   }
