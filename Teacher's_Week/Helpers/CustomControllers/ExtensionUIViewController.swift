//
//  ExtensionUIViewController.swift
//  Teacher's_Week
//
//  Created by jenia kushnarenko on 09/08/2020.
//  Copyright © 2020 jenia kushnarenko. All rights reserved.
//

import UIKit


extension UIViewController {
    
     func alertWithMessage(message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
