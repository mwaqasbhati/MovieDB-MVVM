//
//  Logger.swift
//  TestProject
//
//  Created by MacBook on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation

class Logger {
    class func log(message: String,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        #if DEBUG
            let output = "\(NSDate()): \(message) [\(functionName), line \(lineNumber)]"
            print(output)
        #endif
    }
}
