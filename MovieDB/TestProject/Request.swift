//
//  RequestEncoder.swift
//  TestProject
//
//  Created by MacBook on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation


protocol Request {
    func getURLRequest(url: String) -> URLRequest
}

enum RequestType: Request {
    case MovieList
    case Configuration
    case MovieDetail
    
    init(type: RequestType) {
        self = type
    }
    
    func getURLRequest(url: String) -> URLRequest {
        
        switch self {
        case .MovieList:
            return URLRequest(url: URL(string: url)!)
        case .Configuration:
            return URLRequest(url: URL(string: url)!)
        case .MovieDetail:
            return URLRequest(url: URL(string: url)!)
        }
    }
}
