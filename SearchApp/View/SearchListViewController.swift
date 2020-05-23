//
//  SearchListViewController.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var searchDataSource = [SearchResult.Items]()
    private var cache = NSCache<NSString,AnyObject>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchCell") as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(searchDataSource[indexPath.row], imageFromCache: cache);
        return cell
    }
    
}

extension SearchListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchDetailController = storyboard.instantiateViewController(identifier: "searchDetailViewController") as? SearchDetailViewController {
            searchDetailController.searchItem = self.searchDataSource[indexPath.row]
            self.navigationController?.pushViewController(searchDetailController, animated: true)
        }
    }
    
}
