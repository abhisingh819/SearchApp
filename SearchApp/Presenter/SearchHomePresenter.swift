//
//  SearchHomePresenter.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import Foundation

class SearchHomePresenter {
    private weak var searchHomeView: SearchHomeView?
    
    init(view: SearchHomeView){
        self.searchHomeView = view
    }
    
    func updateModalToView(searchString: String){
        guard let searchV = self.searchHomeView else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            
            let urlString = "https://www.googleapis.com/customsearch/v1?q=\(searchString)&cx=011476162607576381860:ra4vmliv9ti&key=\(Constant.GOOGLE_API_KEY)"
            if let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let apiManager = APIManager.sharedInstance
                
                apiManager.doGet(encodedUrl, headers: ["Content-Type": "application/json","cache-control": "no-cache"]) {[weak self] (data: Data?, error: Bool) in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        if error {
                            print("error in fetching data")
                            
                        }
                        
                        searchV.update(searchResult: self.parseTrip(data: data))
                        
                    }
                    
                }
            }
        }
        
    }
}

private extension SearchHomePresenter {
    
    func parseTrip(data:Data?)->[SearchResult.Items] {
        var searchResultArray = [SearchResult.Items]()
        if let dataItem = data {
            let searchResults = try! JSONDecoder().decode(SearchResult.self, from: dataItem)
            searchResultArray.append(contentsOf: searchResults.items)
        }
        return searchResultArray;
    }
    
}
