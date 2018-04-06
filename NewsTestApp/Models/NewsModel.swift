//
//  NewsModel.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 02.03.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import Foundation


struct ArticlesT: Decodable {
    let status: String
    let totalResults: Int
    let article: [[String:String]]?
}

struct ArticleT: Decodable {
    let source: [SourceT]?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct SourceT: Decodable {
    let id: String?
    let name: String?
}




