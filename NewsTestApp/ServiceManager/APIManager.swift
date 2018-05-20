//
//  APIManager.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 27.02.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String : Any]
typealias ErrorResponse = (Error) -> ()


struct NetworkService {
    static let shared = NetworkService()
    
    private init() {
        
    }
    
    //TODO: - Change to valid url
    private let baseURL = "https://newsapi.org/v2/"
    private let apiKey = "&apiKey=2be2633f942748d58c692ab7e176e560"
    
    //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2be2633f942748d58c692ab7e176e560
    
    func downloadJSON(source: String, onSuccess: @escaping (News) -> (), onFailure: @escaping ErrorResponse) {
        
        //"top-headlines?sources=techcrunch"
        
        Alamofire.request(
            baseURL + source + apiKey,
            method: .get)
            .validate()
            .responseData { response in
                print(response.debugDescription)
                print("This is our \(response.result)")
                
                //TODO: try to find json
                guard let json = response.result.value
                    
                    else {
                        onFailure(response.result.error ?? TestError.other)
                        return
                }
                
                let decoder = JSONDecoder()
                do {
                    let news = try decoder.decode(News.self, from: json)
                    onSuccess(news)
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                    onFailure(error)
                }
        }
    }
}
