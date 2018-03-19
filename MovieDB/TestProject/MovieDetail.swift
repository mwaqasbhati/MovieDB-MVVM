//
//  MovieDetail.swift
//  TestProject
//
//  Created by Muhammad Waqas on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    
    var adult: Bool
    var backdrop_path: String
    var budget: Int
    var release_date: String
    var genres: [Genre]
    var homepage: String
    var original_title: String
    var overview: String
    var status: String
    var tagline: String
    var vote_average: Double
    var vote_count: Int = 0

    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case release_date = "release_date"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case original_title = "original_title"
        case overview = "overview"
        case status = "status"
        case tagline = "tagline"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

