//
//  Global.swift
//  TestProject
//
//  Created by MacBook on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation


extension String {
    
    func getYear() -> String {
        let date = toDate()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return "\(year)"
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.mDate.YYYYMMDD_Format
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
}
