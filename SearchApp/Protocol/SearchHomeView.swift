//
//  SearchHomeView.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import Foundation

protocol SearchHomeView: class {
    func update(searchResult: [SearchResult.Items]);
}
