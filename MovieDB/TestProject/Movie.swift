//
//  DishModel.swift
//  TestProject
//
//  Created by Muhammad Waqas  on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation

struct MovieContainer: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}

struct Movie: Codable {
    
    var vote_count: Int = 0
    var id: Int
    var video: Bool
    var vote_average: Double
    var title: String
    var popularity: Double
    var poster_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var adult: Bool
    var overview: String
    var release_date: String

}

