//
//  Configuration.swift
//  TestProject
//
//  Created by Muhammad Waqas on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation


struct Configuration: Codable {
    let images: Image
}

struct Image: Codable {
    let base_url: String
    let secure_base_url: String
    let poster_size: String = "original"
}
