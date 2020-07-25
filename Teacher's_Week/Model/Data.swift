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
    
    static var students:[Student] = [
                  Student(name: "April Levin"),Student(name: "Arnold Shvartsneger"),
                  Student(name: "Bob Marli"),
                  Student(name: "Bon Jovi"),Student(name: "Ben Gurion"),
                  Student(name: "Chris Brawn"),
                  Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
    
}

extension DataManager {
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
