//
//  SourceModel.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 27.02.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import Foundation
struct Source : Codable {
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
