//
//  Data.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 25/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


//First Prototype for DataManager-Checking Stage
struct ScrollVCData {
    let numberOfLessonsNeed:Int
    let durationOfEachLessonMin:Int
    let needBreaks:Bool
    let maxNumOfLessonsWithoutBreaks:Int
    let paymentPerLesson:Int
    let timeBreak:Int = 10
    let avaiablesAt:[AvaiableAt]
}

struct ScheduleLesson {
    let lessonHolder:ScheduleRequimenets
    let avaiableAt:AvaiableAt
}

struct ScheduleResultTable {
    let lessons:[ScheduleLesson]
    let profit:Int
}

struct AvaiableAt {
    let day:Day
    let from:Date
    let to:Date
    
    var fullDateFrom:Date {
        get {
            return from.addingTimeInterval(TimeInterval(60*60*24*(day.rawValue + 1)))
        }
    }
    
    var fullDateTo:Date {
        get {
            return to.addingTimeInterval(TimeInterval(60*60*24*(day.rawValue + 1)))
        }
    }
}

protocol ScheduleRequimenets {
    var scheduleRequements:ScrollVCData? { get set }
    var name:String { get }
}

struct Student:ScheduleRequimenets {
    
    
    init(firstName:String = "",lastName:String = "" ,phoneNumber:String = "",eMail:String = "",checked:Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.eMail = eMail
        self.checked = checked
    }
    
    var firstName:String = ""
    var lastName:String = ""
    var eMail:String = ""
    var phoneNumber:String = ""
    var checked:Bool = false
    var scheduleRequements: ScrollVCData? = nil
    var name: String {
        get {
           return firstName + " " + lastName
        }
    }
}



struct Group:ScheduleRequimenets {
    var groupName:String = ""
    var students:[Student] = []
    var scheduleRequements: ScrollVCData? = nil
    var checked:Bool? = nil
    var name: String {
        get {
            return groupName
        }
    }
}


struct DataManager {
    
    static var students:[Student] = [
        Student(firstName: "April",lastName: "Levin"),Student(firstName: "Arnold",lastName: " Shvartsneger"),
        Student(firstName: "Bob ",lastName:"Marli")]
    
    static var groups:[Group] = [
        Group(groupName: "Eagles", students: DataManager.students)
    ]
    
}

//MARK: - GroupManagment
extension DataManager {
    
    static func getGroupsInFormatSectionInfo() -> [SectionInfo] {
        //TODO:Complete and then in HomeVC set info to ListCollectionVC
        let cellsInfo:[CellInfo] = groups.map { (group) -> CellInfo in
            let numOfStudentsInGroup = group.students.count
            let subTitle = numOfStudentsInGroup > 1 ? "\(numOfStudentsInGroup) Students" : numOfStudentsInGroup == 0 ? "No Students" : "1 Student"
            let cellInfo = CellInfo(title: group.groupName, subtitle: subTitle, isAccessory: false, relatedTo: group)
            return cellInfo
        }
       let sectionInfo = SectionInfo(headerTitle: "", cellsInfo: cellsInfo)
        return [sectionInfo]
    }
    
}

//MARK: - StudentManagment
extension DataManager {
    
    static func addNewStudent(firstName:String,lastName:String = "",phoneNumber:String = "",eMail:String = "") {
        students.append(Student(firstName: firstName,lastName: lastName,phoneNumber: phoneNumber,eMail: eMail))
    }
    
    static func getStudentsInFormatSectionsInfo() -> [SectionInfo] {
        var sectionsInfo:[SectionInfo] = []
        var cellsInfo:[CellInfo] = []
        students.forEach { (student) in
            cellsInfo.append(CellInfo(title: student.firstName + " " + student.lastName, subtitle: "abraCadabra", isAccessory: student.checked,relatedTo:student))
        }
        sectionsInfo.append(SectionInfo(headerTitle: "A", cellsInfo: cellsInfo))
        return sectionsInfo
    }
    
    static func updateStudentCheckedStatus(firstName:String,lastName:String,checked:Bool) {
        guard let studentIndex = (students.firstIndex{$0.firstName.trimmingCharacters(in: .whitespaces) == firstName && $0.lastName.trimmingCharacters(in: .whitespaces) == lastName }) else {return}
        students[studentIndex].checked = checked
    }
    
    static func resetStudentsCheckedStatus() {
        DataManager.students =  students.map({ (student) -> Student in
            Student(firstName: student.firstName, lastName: student.lastName, phoneNumber: student.phoneNumber, eMail: student.eMail,checked: false)
        })
    }
    
}

//MARK: - General
extension DataManager {
    static func filterSectionsInfoByText(sectionsInfo:[SectionInfo],text:String)->[SectionInfo] {
         var filteredSectionsInfo:[SectionInfo] = []
         sectionsInfo.forEach { (sectionInfo) in
             var filteredCells:[CellInfo] = []
              filteredCells = sectionInfo.cellsInfo.filter { (cellInfo) -> Bool in
                 return cellInfo.title?.contains(text) ?? false
             }
             print("filteredCount:\(filteredCells.count)")
             guard  filteredCells.count != 0 else {return}
             let headerFilteredSection:String = String(filteredCells[0].title?.first ?? " ")
             let filteredSectionInfo = SectionInfo(headerTitle: headerFilteredSection, cellsInfo: filteredCells)
             filteredSectionsInfo.append(filteredSectionInfo)
         }
         return filteredSectionsInfo
     }
}
