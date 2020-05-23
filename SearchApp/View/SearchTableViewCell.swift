//
//  SearchTableViewCell.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchImgView: SearchImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var dataTask: URLSessionDataTask?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        dataTask = nil
        self.searchImgView.image = nil
    }

}

extension SearchTableViewCell {
    
    func configureCell(_ search:SearchResult.Items, imageFromCache:NSCache<NSString,AnyObject>) {
        
        if let title = search.title {
            self.titleLbl.text = title
        }else {
           self.titleLbl.text = ""
        }
        
        if let desc = search.snippet {
            self.descLbl.text = desc
        }else {
           self.descLbl.text = ""
        }
        
        if dataTask == nil {
            if let cseThumbnail = search.pagemap?.cse_thumbnail, cseThumbnail.count > 0, let thumbnailString = cseThumbnail[0].src {
                dataTask = self.searchImgView.loadImageFromAPI(imageFromCache: imageFromCache, urlString: thumbnailString)
            } else if let cseImage = search.pagemap?.cse_image, cseImage.count > 0, let thumbnailString = cseImage[0].src {
                dataTask = self.searchImgView.loadImageFromAPI(imageFromCache: imageFromCache, urlString: thumbnailString)
            }
        }
    }
    
}
