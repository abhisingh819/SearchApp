//
//  APIManager.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/14/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import Foundation

class APIManager {
    
    static let sharedInstance = APIManager()
    
    func doGet(_ url:String, headers:[String:String]?, completionHandler: @escaping(Data?, Bool) -> Void) {
        
        var urlRequest: URLRequest? = nil
        if let url1 = URL(string: url) {
            urlRequest = URLRequest(url: url1)
        }
        
        if var urlReq = urlRequest {
            urlReq.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: urlReq, completionHandler: { data, response, error in
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    completionHandler(data, false)
                } else {
                    print("Error")
                    completionHandler(nil, true)
                }
            })
            dataTask.resume()
        }
        
    }
    
    func doGetImage(_ url:String, headers:[String:String]?, completionHandler: @escaping (Data?) -> Void) -> URLSessionDataTask? {
        
        let url = URL(string: url)

        let session = URLSession.shared

        var dataTask: URLSessionDataTask? = nil
        if let url = url {
            dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
                if error != nil {
                    if let error = error {
                        print("\(error)")
                    }
                    completionHandler(nil)
                    return
                }

                completionHandler(data)

            })
        }
        dataTask?.resume()
        return dataTask
        
    }
}
