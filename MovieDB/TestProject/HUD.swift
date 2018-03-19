//
//  HUD.swift
//  TestProject
//
//  Created by Muhammad Waqas Bhati on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation
import MBProgressHUD


class HUD {
    
    static func show(view: UIView?) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }
    static func hide(view: UIView?) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
}
