//
//  ProfileModel.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 12/09/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


struct ProfileModel {
    
    struct DefaultSettings {
          static var breaksBetweenLessons:Int = 10
          static var lessonDuration:Int = 45
          static var lessonPrice:Int = 100
        
        static var getInfo:SectionInfo {
            get {
               return SectionInfo(headerTitle: "Default Settings", cellsInfo: [
                CellInfo(title: "Breaks Between Lessons", subtitle: "\(self.breaksBetweenLessons) Minutes", isAccessory: true, relatedTo: nil),
                CellInfo(title: "Lesson Duration", subtitle: "\(self.lessonDuration) Minutes", isAccessory: true, relatedTo: nil),
                CellInfo(title: "Lesson Price", subtitle: "\(self.lessonPrice) $", isAccessory: true, relatedTo: nil)
               ])
            }
        }
    }
    
    struct General {
        static var getInfo:SectionInfo {
            get {
                return SectionInfo(headerTitle: "General", cellsInfo: [
                CellInfo(title: "Terms Of Use", subtitle: "", isAccessory: true, relatedTo: nil),
                CellInfo(title: "Privacy Policy", subtitle: "", isAccessory: true, relatedTo: nil),
                CellInfo(title: "Credits", subtitle: "", isAccessory: true, relatedTo: nil)
                ])
            }
        }
    }
    
//    static var info:[SectionInfo] = [
//        DefaultSettings.getInfo,
//        General.getInfo
//    ]
    
    static func getInfo()->[SectionInfo] {
        return [DefaultSettings.getInfo,General.getInfo]
    }
    
    
}
