//
//  Contacts.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 21/06/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import Foundation
import Contacts



struct ContactsManager {
    
    static public var contacts:[Student] = []
    
    static public var shared = ContactsManager()
    
    init() {
        let store = CNContactStore()
        
        let executeFunctionIfGranted = {
            let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
            do {
                try store.enumerateContacts(with: request) { (contact, pointer) in
                    let fullName = contact.givenName + " " + contact.familyName
                    ContactsManager.contacts.append(Student(name: fullName))   //Add New Contact
                }
            } catch let err {
                print("Fetch Error:\(err.localizedDescription)")
            }
        }
        self.executeFunctionIfContactsGranted(executeFunctionGranted: executeFunctionIfGranted, executeFunctionNotGranted: {})
    }
//        get {
//            let store = CNContactStore()
//            var contacts:[Student] = []
//
//            let executeFunctionIfGranted = {
//                let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
//                do {
//                    try store.enumerateContacts(with: request) { (contact, pointer) in
//                        let fullName = contact.givenName + " " + contact.familyName
//                        contacts.append(Student(name: fullName))   //Add New Contact
//                    }
//                } catch let err {
//                    print("Fetch Error:\(err.localizedDescription)")
//                }
//            }
//            executeFunctionIfContactsGranted(executeFunctionGranted: executeFunctionIfGranted, executeFunctionNotGranted: {})
//            return contacts
//        }
//    }

//    static func setContactAt(index:Int,contact:Student) {
//        contacts[index] = contact
//    }
    
//    static func getContactAt(index:Int)->Student {
//        return contacts[index]
//    }
    
    
//    static func getContacts()->[Student] {
//        let store = CNContactStore()
//        var resultContacts:[Student] = []
//
//        let executeFunctionIfGranted = {
//            let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
//            do {
//                try store.enumerateContacts(with: request) { (contact, pointer) in
//                    let fullName = contact.givenName + " " + contact.familyName
//                    resultContacts.append(Student(name: fullName))   //Add New Contact
//                }
//            } catch let err {
//                print("Fetch Error:\(err.localizedDescription)")
//            }
//        }
//        executeFunctionIfContactsGranted(executeFunctionGranted: executeFunctionIfGranted, executeFunctionNotGranted: {})
//        self.contacts = resultContacts
//        return resultContacts
//    }
    
    public func updateContactCheckedStatus(name:String,checked:Bool) {
        guard let studentIndex = (ContactsManager.contacts.firstIndex{$0.name == name}) else {return}
        ContactsManager.contacts[studentIndex].checked = checked
       }
    
    public func executeFunctionIfContactsGranted(executeFunctionGranted:@escaping ()->Void,executeFunctionNotGranted:@escaping ()->Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let err = error {
                print("Error Access Contacts:\(err.localizedDescription)")
            }
            granted == true ? executeFunctionGranted() : executeFunctionNotGranted()
        }
    }
    
    
    public func getSectionsInfo() -> [SectionInfo] {
        var sectionsInfo:[SectionInfo] = []
        var cellsInfo:[CellInfo] = []
        
       
        ContactsManager.contacts.forEach { (student) in
            cellsInfo.append(CellInfo(title: student.name, subtitle: "someAbra", isAccessory: student.checked))
        }
        sectionsInfo.append(SectionInfo(headerTitle: "A", cellsInfo: cellsInfo))
        
        
           return sectionsInfo
        }
    
    
//
//    static func getContacts() {
//
//        print("Get Contacts")
//        let store = CNContactStore()
//
//        store.requestAccess(for: .contacts) { (granted, error) in
//            if let err = error {
//                print("Error Access Contacts:\(err.localizedDescription)")
//            }
//            guard granted != false else {
//                print("Go To Settings And Change Access Settings For This App")
//                return
//
//            }
//            let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey] as [CNKeyDescriptor])
//            contacts.removeAll()
//            do {
//                try store.enumerateContacts(with: request) { (contact, pointer) in
//                    let fullName = contact.givenName + " " + contact.familyName
//                    contacts.append(Student(name: fullName))   //Add New Contact
//                }
//            } catch let err {
//                print("Fetch Error:\(err.localizedDescription)")
//            }
//        }
//
//    }
    
}


//    static func getContacts()->[Character:[Student]] {
//
//              let contacts:[Character:[Student]] = [
//                "A":[Student(name: "April Levin"),Student(name: "Arnold Shvartsneger")],
//                "B":[Student(name: "Bob Marli"),Student(name: "Bon Jovi"),Student(name: "Ben Gurion")],
//                "C":[Student(name: "Chris Brawn")],
//                "M":[Student(name: "Mark Tsugenberg"),Student(name: "Messi")]
//            ]
//
//        return contacts
//    }


//
//        let contacts = ContactsManager.getContacts()  //[Character:[Student]
//            //sectionInfo
//            let sectionsInfo:[SectionInfo] = {
//                let sections = contacts.map { (contactsPerKey) -> SectionInfo in
//
//                    let headerTitle = contactsPerKey.key
//
//                    let cellsInfo:[CellInfo] = contactsPerKey.value.map { (contactsInKey) -> CellInfo in
//                        let cellInfo = CellInfo(title:contactsInKey.name, subtitle: "subtitle",isAccessory:contactsInKey.checked)
//                        return cellInfo
//                    }
//
//                    let section = SectionInfo(headerTitle:String(headerTitle),cellsInfo:cellsInfo)
//                    return section
//                }
//                return sections
//            }()
