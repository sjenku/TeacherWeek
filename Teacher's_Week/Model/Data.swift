//
//  Data.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 25/07/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


//First Prototype for DataManager-Checking Stage

struct DataManager {
    
//    static var students:[Student] = [
//                  Student(name: "April Levin"),Student(name: "Arnold Shvartsneger"),
//                  Student(name: "Bob Marli"),
//                  Student(name: "Bon Jovi"),Student(name: "Ben Gurion"),
//                  Student(name: "Chris Brawn"),
//                  Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
    static var students:[Student] = [
                     Student(name: "April Levin"),Student(name: "Arnold Shvartsneger"),
                     Student(name: "Bob Marli")]
    
}

//MARK: - StudentManagment
extension DataManager {
    
    static func addNewStudent(name:String) {
        students.append(Student(name: name))
    }
    
    static func getStudentsInFormatSectionsInfo() -> [SectionInfo] {
        var sectionsInfo:[SectionInfo] = []
        var cellsInfo:[CellInfo] = []
        students.forEach { (student) in
            cellsInfo.append(CellInfo(title: student.name, subtitle: "abraCadabra", isAccessory: student.checked))
        }
        sectionsInfo.append(SectionInfo(headerTitle: "A", cellsInfo: cellsInfo))
        return sectionsInfo
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
