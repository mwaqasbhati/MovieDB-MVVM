//
//  NetworkError.swift
//  TestProject
//
//  Created by MacBook on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case noNetwork
    case serverError(String)
    case parsingError(String)
    case unknown(String)
}

extension NetworkError: LocalizedError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check you are connected to internet."
        case .serverError(let error):
            return error
        case .parsingError(let error):
            return error
        case .unknown(let url):
            return url
        }
    }
}
