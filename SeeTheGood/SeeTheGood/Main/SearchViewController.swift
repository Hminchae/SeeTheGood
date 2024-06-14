//
//  MainViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit

class SearchViewController: UIViewController {
    
    let user = UserDefaultManager.shared
    
    private let searchTextField = {
        let textField = UITextField()
        textField.placeholder = "브랜드, 상품 등을 입력하세요."
        
        return textField
    }()
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private let topLineView = {
        let view = UIView()
        view.backgroundColor = .thirdGray
        
        return view
    }()
    
    private let emptyView = UIView()
    
    private let emptyImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let emptyLabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요"
        label.textAlignment = .center
        label.font = ViewConstant.Font.heavy16
        
        return label
    }()
    
    private let bottomLineView = {
        let view = UIView()
        view.backgroundColor = .thirdGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(user.nickName)'s See The Good"
        view.backgroundColor = .white
        
        configureView()
    }
    
    func configureView() {
        view.addSubview(searchBar)
        view.addSubview(topLineView)
        view.addSubview(emptyView)
        view.addSubview(bottomLineView)
        
        configureEmptyView()
        configureLayout()
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(35)
        }
        
        topLineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
    
    func configureEmptyView() {
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(emptyView.snp.center)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emptyView.snp.horizontalEdges)
            make.height.equalTo(20)
        }
    }
}
