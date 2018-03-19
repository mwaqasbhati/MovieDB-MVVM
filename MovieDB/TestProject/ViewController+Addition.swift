//
//  ViewController+Addition.swift
//  TestProject
//
//  Created by Muhammad Waqas  on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertInViewController(titleStr :String?, messageStr :String, okButtonTitle :String,response :((_ dismissedWithCancel: Bool) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let controller = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) in
                if response != nil {
                    response!(true)
                }
            })
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
    }    
}
