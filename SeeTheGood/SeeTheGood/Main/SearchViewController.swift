//
//  MainViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    
    private let user = UserDefaultManager.shared
    private var list: [String] = ["냠냠", "쩝쩝", "배고파롱"]
    
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
    
    private let notEmptyView = UIView()
    
    private let recentSearchLabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.textColor = .black
        label.font = ViewConstant.Font.bold15
        
        return label
    }()
    
    private let deleteAllButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.point, for: .normal)
        button.titleLabel?.font = ViewConstant.Font.normal13
        
        return button
    }()
    
    private let tableView = UITableView()
    
    private let bottomLineView = {
        let view = UIView()
        view.backgroundColor = .thirdGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(user.nickName)'s See The Good"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        searchBar.delegate = self
        
        configureView()
    }
    
    private func configureView() {
        view.addSubview(searchBar)
        view.addSubview(topLineView)
        
        if list.isEmpty {
            configureEmptyView()
        } else {
            configureNotEmptyView()
        }
        
        view.addSubview(bottomLineView)
        configureLayout()
    }

    private func configureLayout() {
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
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
    
    private func configureEmptyView() {
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)
        view.addSubview(emptyView)
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(emptyView.snp.center)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emptyView.snp.horizontalEdges)
            make.height.equalTo(20)
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
    
    private func configureNotEmptyView() {
        notEmptyView.addSubview(recentSearchLabel)
        notEmptyView.addSubview(deleteAllButton)
        notEmptyView.addSubview(tableView)
        view.addSubview(notEmptyView)
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(notEmptyView.snp.top).offset(15)
            make.leading.equalTo(notEmptyView.snp.leading).offset(15)
            make.height.equalTo(20)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.top.equalTo(notEmptyView.snp.top).offset(15)
            make.trailing.equalTo(notEmptyView.snp.trailing).inset(15)
            make.height.equalTo(20)
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(notEmptyView.snp.horizontalEdges)
            make.bottom.equalTo(notEmptyView.snp.bottom)
        }
        
        notEmptyView.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

// 네트워크
extension SearchViewController {
    
    func callRequest(query: String) {
        let url = "\(APIKey.url.rawValue)?query=\(query)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID.rawValue,
            "X-Naver-Client-Secret": APIKey.clientSecret.rawValue
        ]
        
        AF.request(url,
                   method: .get,
                   headers: header)
        .responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                print(response)
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        callRequest(query: text)
        list.append(text)
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        cell.searchRecordLabel.text = list.reversed()[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        print("힝")
    }
}
