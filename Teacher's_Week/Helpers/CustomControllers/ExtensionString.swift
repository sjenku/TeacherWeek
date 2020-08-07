//
//  ExtensionString.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 07/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation


extension String {
    func SpliteToTwoStrings()->(String,String) {
        let str = self.split(separator: " ")
        let firstStr = String(str[0])
        let secStr = str.count > 1 ? String(str[1]) : ""
        return (firstStr,secStr)
    }
}
