//
//  NetworkManager.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/24/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(query: String, sort: String, page: Int, completionHandler: @escaping (Search?, NetworkError?) -> Void) {
        var component = URLComponents()
        
        component.scheme = "https"
        component.host = "openapi.naver.com"
        component.path = "/v1/search/shop.json"
        
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "start", value: String(page))
        ]
        
        guard let url = component.url else {
            completionHandler(nil, .invalidResponse)
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.addValue(APIKey.clientID.rawValue, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.clientSecret.rawValue, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request: \(error!.localizedDescription)")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    print("Unable Response")
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response with status code: \(response.statusCode)")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Search.self, from: data)
                    completionHandler(result, nil)
                    print(result)
                    print("Success")
                } catch {
                    print("Error")
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
}
