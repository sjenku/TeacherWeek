//
//  Data.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 25/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


//First Prototype for DataManager-Checking Stage


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


struct Group {
    var groupName:String = ""
    var students:[Student] = []
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
            let cellInfo = CellInfo(title: group.groupName, subtitle: subTitle, isAccessory: nil, relatedTo: group)
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
