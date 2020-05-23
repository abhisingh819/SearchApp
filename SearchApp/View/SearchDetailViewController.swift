//
//  SearchDetailViewController.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/14/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var searchDetailImgView: SearchImageView!
    var searchItem:SearchResult.Items?
    private var dataTask: URLSessionDataTask? = nil
    private var imageFromCache =  NSCache<NSString, AnyObject>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataTask?.cancel()
        dataTask = nil
        self.searchDetailImgView.image = nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //Action Methods
    
    
    @IBAction func openLink(_ sender: UIButton) {
        
        if let link = searchItem?.link, let url = URL(string: link){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
}

extension SearchDetailViewController {
    
    func initDetails(){
        if let title = searchItem?.title {
           self.titleLbl.text = title
        }else {
            self.titleLbl.text = ""
        }
        
        if let snippet = searchItem?.snippet {
           self.DescLbl.text = snippet
        }else {
            self.DescLbl.text = ""
        }
        
        if dataTask == nil {
            if let cseImage = searchItem?.pagemap?.cse_image, cseImage.count > 0, let thumbnailString = cseImage[0].src {
                dataTask = self.searchDetailImgView.loadImageFromAPI(imageFromCache: imageFromCache, urlString: thumbnailString)
            } else if let cseThumbnail = searchItem?.pagemap?.cse_thumbnail, cseThumbnail.count > 0, let thumbnailString = cseThumbnail[0].src {
                dataTask = self.searchDetailImgView.loadImageFromAPI(imageFromCache: imageFromCache, urlString: thumbnailString)
            }
        }
    }
    
}
