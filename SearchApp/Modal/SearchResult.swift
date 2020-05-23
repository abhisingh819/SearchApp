//
//  SearchResult.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    struct Items: Codable {
        var kind: String?
        var title: String?
        var snippet: String?
        var link: String?
        
        struct PageMap: Codable {
            struct CseThumbnail: Codable {
                var width: String?
                var height: String?
                var src: String?
            }
            struct CseImage: Codable {
                var src: String?
            }
            var cse_thumbnail:[CseThumbnail]?
            var cse_image:[CseImage]?
        }
        var pagemap: PageMap?
    }
    var items:[Items]
}
