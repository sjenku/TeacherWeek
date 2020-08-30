//
//  ScheduleManager.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 11/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation

struct ResultTuple {
    let value:(Int,Int)
    init (_ fVal:Int,_ sVal:Int) {
        value = (fVal,sVal)
    }
    static func +(lhs:ResultTuple,rhs:ResultTuple)->ResultTuple {
        return ResultTuple(lhs.value.0 + rhs.value.0,lhs.value.1 + rhs.value.1)
    }
}

class ScheduleManager {
    
    //MARK: - Properties
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
    
    
    
    //This Propertie is helper propertie and not for use except 'scheduleFromStudents' propertie
    fileprivate static var findSolutionResult:[ScheduleLesson] = []
    
    static fileprivate func retriveAllPossiableLessonsTimesInSortedWay()->[ScheduleLesson] {
        var scheduleLessons:[ScheduleLesson] = []
              for student in students {
                  if let studentRequients = student.scheduleRequements {
                      scheduleLessons.append(contentsOf:appendAllLessonsFromAvaibleAtRange(lessonsHolder: student, price: studentRequients.paymentPerLesson, avaiblesAt: studentRequients.avaiablesAt, lessonDurationMin: studentRequients.durationOfEachLessonMin,intervalMin: 5))
                  }
              }
              //Collect all groups avaiableTimes
              for group in groups {
                  if let groupRequiments = group.scheduleRequements {
                      scheduleLessons.append(contentsOf: appendAllLessonsFromAvaibleAtRange(lessonsHolder: group, price: groupRequiments.paymentPerLesson, avaiblesAt: groupRequiments.avaiablesAt, lessonDurationMin: groupRequiments.durationOfEachLessonMin, intervalMin: 5))
                  }
              }
              
              //1.sort all lessons by finish time
              scheduleLessons.sort { (firstLesson, secondLesson) -> Bool in
                  let dayTimeInterval = 60*60*24
                  let firstLessonFullTimeTo = firstLesson.avaiableAt.to.addingTimeInterval(TimeInterval(dayTimeInterval * (firstLesson.avaiableAt.day.rawValue + 1)))
                  let secondLessonFullTimeTo = secondLesson.avaiableAt.to.addingTimeInterval(TimeInterval(dayTimeInterval * (secondLesson.avaiableAt.day.rawValue + 1)))
                  return firstLessonFullTimeTo < secondLessonFullTimeTo
              }
        return scheduleLessons
    }
    
    static var allCombinationSchedules:[ScheduleResultTable] {
        get {
             //1.sort all lessons by finish time
            let scheduleLessons:[ScheduleLesson] = retriveAllPossiableLessonsTimesInSortedWay()
             //2.create array holding index of lesson that not overrlaping with current lesson
            let notConflictingIndexs:[Int] = lastNotConflictingLessons(scheduleLessons)
             //3.for each subset create schedule
            let schedules = retriveAllSchedulesFromAllSets(lessons: scheduleLessons, pairIndexs: notConflictingIndexs)
             //4.sort schedules by success
            return schedules
        }
    }
    
    
    //Main Calculation For Maximum Profit Schedule From Student Lessons
    static var maxProfitSchedules:[ScheduleResultTable] {
        get {
            
            //1.sort all lessons by finish time
            var scheduleLessons:[ScheduleLesson] = retriveAllPossiableLessonsTimesInSortedWay()
            //2.create array holding index of lesson that not overrlaping with current lesson
            var notConflictingIndexes:[Int] = lastNotConflictingLessons(scheduleLessons)

            //3.create recursive function 'optimal' that calculate optimal profit from lessons
            let optVal = ScheduleManager.optimal(&scheduleLessons,&notConflictingIndexes,scheduleLessons.count - 1)

            //4.create function that find-solution with help of 'optimal' function
            calculateResultSubsetWithMaxProfit(lessons: scheduleLessons, p: notConflictingIndexes)
            
            let tableLessons:[ScheduleLesson] = ScheduleManager.findSolutionResult
            ScheduleManager.findSolutionResult = [] //reset for not adding future lessons

            //TODO: create another iterative apporach for finding optimal profit
            return [ScheduleResultTable(lessons: tableLessons, profit: optVal)]
        }
    }

    
    
    //MARK: - Helper Methods For Calculating Scheudles
    fileprivate static func retriveAllSchedulesFromAllSets(lessons:[ScheduleLesson],pairIndexs:[Int])->[ScheduleResultTable] {
        var schedules:[ScheduleResultTable] = []
        for (index,_) in lessons.enumerated() {
            let scheduleLessonsSet = lessonsSet(lessons: lessons, pairIndex: pairIndexs, index: index)
            let profit = profitSumOfSubset(lessons: lessons, p: pairIndexs, index: index)
            let schedule = ScheduleResultTable(lessons: scheduleLessonsSet, profit: profit)
            schedules.append(schedule)
        }
        return schedules
    }
    
    fileprivate static func lessonsSet(lessons:[ScheduleLesson],pairIndex:[Int],index:Int)->[ScheduleLesson] {
        var scheudleLessons:[ScheduleLesson] = []
        if index != -1 {
            scheudleLessons.append(ScheduleLesson(lessonHolder: lessons[index].lessonHolder, avaiableAt: lessons[index].avaiableAt))
            scheudleLessons.append(contentsOf: lessonsSet(lessons: lessons, pairIndex: pairIndex, index: pairIndex[index]))
        }
        return scheudleLessons
    }
    
    fileprivate static func appendAllLessonsFromAvaibleAtRange(lessonsHolder:ScheduleRequimenets,price:Int,avaiblesAt:[AvaiableAt],lessonDurationMin:Int,intervalMin:Int)->[ScheduleLesson] {
        var allLessons:[ScheduleLesson] = []
        for avaibleAt in avaiblesAt {
            
            var lessonStartTime = avaibleAt.from
            var lessonEndTime = avaibleAt.from.addingTimeInterval(TimeInterval(lessonDurationMin*60))
            
            while lessonEndTime <= avaibleAt.to {
                let scheudleLesson:ScheduleLesson = ScheduleLesson(lessonHolder: lessonsHolder, avaiableAt: AvaiableAt(day: avaibleAt.day, from: lessonStartTime, to: lessonEndTime))
                allLessons.append(scheudleLesson)
                lessonStartTime = lessonStartTime.addingTimeInterval(TimeInterval(intervalMin*60))
                lessonEndTime = lessonStartTime.addingTimeInterval(TimeInterval(lessonDurationMin*60))
            }
          }
         return allLessons
        }
    
    //MARK: - Helper Methods For Calculate Optimal Schedule
    //MARK: Using Algorithm: 'Weighted Interval Scheudle'
    
    
    static fileprivate func calculateResultSubsetWithMaxProfit(lessons:[ScheduleLesson],p:[Int]) {
        var maxProfit:Int = 0
        var maxIndex:Int = 0
        for (index,_) in lessons.enumerated() {
            let newMaxProfit = max(maxProfit, profitSumOfSubset(lessons: lessons, p: p, index: index))
            if newMaxProfit > maxProfit {
                maxProfit = newMaxProfit
                maxIndex = index
            }
        }
        appendSubSetStartAtIndex(fromLessons: lessons, p: p, index: maxIndex)
    }
    
    static fileprivate func profitSumOfSubset(lessons:[ScheduleLesson],p:[Int],index:Int)->Int {
          if index == -1 {
              return 0
          }
          return lessons[index].lessonHolder.scheduleRequements!.paymentPerLesson + profitSumOfSubset(lessons: lessons, p: p, index: p[index])
      }
    
    static fileprivate func appendSubSetStartAtIndex(fromLessons:[ScheduleLesson],p:[Int],index:Int) {
        if index != -1 && fromLessons.count != 0 {
            ScheduleManager.findSolutionResult.append(fromLessons[index])
            appendSubSetStartAtIndex(fromLessons: fromLessons,p: p, index:p[index])
        }
    }
    
    
    fileprivate static func optimal(_ lessons:inout [ScheduleLesson],_ p:inout [Int],_ j:Int)->Int { //O(2^n) bad time complexity
        if j == -1 {
            return 0
        } else {
            return max(lessons[j].lessonHolder.scheduleRequements!.paymentPerLesson + optimal(&lessons,&p,p[j]),optimal(&lessons,&p,j-1))
        }
    }
    
    fileprivate static func lastNotConflictingLessons(_ lessons:[ScheduleLesson])->[Int] {   //O(n^2)
        var p:Array<Int> = Array(repeating: -1, count: lessons.count)
        for (indexLesson,lesson) in lessons.enumerated() {
            for index in stride(from: indexLesson, to: -1, by: -1) {
                //check if times not collapsing between the lessons
                if(lesson.avaiableAt.fullDateFrom >= lessons[index].avaiableAt.fullDateTo) {
                    //1.check all limits...if ok put index else just dont
                     p[indexLesson] = index
                    let subResult = subSetThatStartAtIndex(lessons:lessons,lessonHolderName: lessons[indexLesson].lessonHolder.name,p: p, index: indexLesson,lessonsStartTime: lessons[indexLesson].avaiableAt.fullDateFrom)
                    //if more then numberOfLessons needed or more then lessons without break then disable this subset
                    if subResult.value.0 > lesson.lessonHolder.scheduleRequements!.numberOfLessonsNeed ||
                        (lesson.lessonHolder.scheduleRequements!.maxNumOfLessonsWithoutBreaks != 0 && subResult.value.1 > lesson.lessonHolder.scheduleRequements!.maxNumOfLessonsWithoutBreaks){
                        p[indexLesson] = -1
                    } else {
                       break
                    }
                }
            }
        }
        return p
    }
    
    
    private static func subSetThatStartAtIndex(lessons: [ScheduleLesson],lessonHolderName:String,p:[Int],index:Int,lessonsStartTime:Date)->ResultTuple { //num of lessons in subset
        //next thing is to check if it's not passed the limit of lessons for student
        if index == -1 {
            return ResultTuple(0,1)
        }
        let resultSubSet = subSetThatStartAtIndex(lessons:lessons,lessonHolderName: lessonHolderName,p: p, index: p[index],lessonsStartTime: lessons[index].avaiableAt.fullDateFrom)
        let lessonCounter =  lessons[index].lessonHolder.name == lessonHolderName ? 1 : 0
        let lessonsBreakCounter = lessons[index].avaiableAt.fullDateTo == lessonsStartTime ? 1 : 0
        let result = resultSubSet + ResultTuple(lessonCounter,lessonsBreakCounter)
        
        return result
    }
    
    //MARK: - Retrive Lessons in model that fit view representation
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
    
    //Function For Represent ScheduleLessons In View
    static func sectionInfoForScheduleResults(schedule:ScheduleResultTable)->[SectionInfo] {
//         guard let scheudle = ScheduleManager.maxProfitSchedules.first else {return []}
         var sectionsInfo:[SectionInfo] = []
        var cellsInfo:[CellInfo] = []
        var daysCellsArr:Array<Array<CellInfo>> = Array(repeating: [], count: 7)
        schedule.lessons.forEach { (lesson) in
            let cellInfo = CellInfo(title: lesson.lessonHolder.name, subtitle: lesson.avaiableAt.from.toString + " - " + lesson.avaiableAt.to.toString, isAccessory: nil, relatedTo: lesson)
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
