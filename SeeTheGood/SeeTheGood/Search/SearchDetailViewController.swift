//
//  SearchDetailViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/16/24.
//

import UIKit
import WebKit

import SnapKit

final class SearchDetailViewController: UIViewController {
    
    var link: String?
    var productTitle: String?
    var isSelected = false
    
    private let webView = WKWebView()
    private let topLineView = LineView()
    private let bottomLineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureView()
        
        if let link = link, let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func configureView() {
        view.addSubview(webView)
        view.addSubview(topLineView)
        view.addSubview(bottomLineView)
        
        configureNavigationBar()
        configureLayout()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = productTitle
        let basket = UIBarButtonItem(
            image: isSelected ? UIImage(named: "like_selected") : UIImage(named: "like_unselected"),
            style: .plain,
            target: self,
            action: #selector(basketButtonClicked))
        
        navigationItem.rightBarButtonItem = basket
    }
    
    @objc func basketButtonClicked(_ sender: UIButton) {
        
        print("크흠... 귀찮다")
        isSelected.toggle()
    }
    
    private func configureLayout() {
        topLineView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        webView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
}
