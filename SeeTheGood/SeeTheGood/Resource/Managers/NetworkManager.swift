//
//  NetworkManager.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/24/24.
//

import Foundation

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequest(query: String, sort: String, page: Int, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        let url = "\(APIKey.url.rawValue)?query=\(query)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID.rawValue,
            "X-Naver-Client-Secret": APIKey.clientSecret.rawValue
        ]
        let para: Parameters = [
            "query": query,
            "display":30,
            "sort": sort,
            "page": page,
        ]
        
        AF.request(url, method: .get, parameters: para, headers: header)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
