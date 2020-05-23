//
//  ViewController.swift
//  SearchApp
//
//  Created by Abhinav Singh on 5/13/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var searchHomePresenter : SearchHomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        searchHomePresenter = SearchHomePresenter(view: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.activityIndicator.stopAnimating()
    }
    
    
    //Action Methods
    
    @IBAction func searchResults(_ sender: UIButton) {
        guard let presenter = searchHomePresenter else {
            return
        }
        
        if let text = searchTextField.text, text.trimmingCharacters(in: .whitespaces) != "" {
            presenter.updateModalToView(searchString: text)
            self.activityIndicator.startAnimating()
        } else {
            showAlert(title: "Required", message: "Please enter something to search")
        }
    }
    


}

extension ViewController : SearchHomeView {
    
    func update(searchResult: [SearchResult.Items]){
        self.activityIndicator.stopAnimating()
        if(searchResult.count == 0){
            showAlert(title: "No Result", message: "No search results found for your query")
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let searchListController = storyboard.instantiateViewController(identifier: "searchListViewController") as? SearchListViewController {
                searchListController.searchDataSource.append(contentsOf: searchResult)
                self.navigationController?.pushViewController(searchListController, animated: true)
            }
        }
    }
    
}

extension ViewController {
    
    func showAlert(title: String, message: String) {
        let objAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:
        {Void in
            
            
        })
        
        objAlertController.addAction(objAction)
        present(objAlertController, animated: true, completion: nil)
    }
    
}

extension ViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

