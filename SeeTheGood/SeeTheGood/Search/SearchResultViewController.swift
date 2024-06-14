//
//  SearchResultViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searchWord: String?
    var searchResult: Search?
    
    private let lineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        
        if let title = searchWord {
            navigationItem.title = title
        }
        
        self.navigationController?.navigationBar.tintColor = .black
    }
}
