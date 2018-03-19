//
//  Constants.swift
//  TestProject
//
//  Created by Muhammad Waqas on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation


enum Constant {
    case CONFIG_URL
    case MOVIE_URL
    case MOVIE_DETAIL_URL
    case MOVIE_FILTER_URL
    
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let API_KEY = "44d1c4d4e6c925a008c431d73ae8ff4a"
    static var IMAGE_URL = ""
    
    static func makeImagePath(url: String) -> String {
        return (Constant.IMAGE_URL + url)
    }
    
    var path: String {
        switch self {
        case .CONFIG_URL:
            return "https://api.themoviedb.org/3/configuration?api_key=\(Constant.API_KEY)"
        case .MOVIE_URL:
            return Constant.BASE_URL + "/movie/popular?api_key=\(Constant.API_KEY)"
        case .MOVIE_DETAIL_URL:
            return Constant.BASE_URL + "/movie/"
        case .MOVIE_FILTER_URL:
            return "https://api.themoviedb.org/3/discover/movie?api_key=\(Constant.API_KEY)"
        }
    }
    
    struct Alert {
        static let title = "Alert"
        static let message = "Max year can not be less than minimum year"
        static let ok = "OK"
        static let cancel = "Cancel"
    }
    struct Parsing {
        static let message = "Json Parsing Error"
        static let unKnown = "UnKnown Error occur, please try again"
    }
    struct mDate {
        static let YYYYMMDD_Format = "YYYY-MM-DD"
    }
    
}

