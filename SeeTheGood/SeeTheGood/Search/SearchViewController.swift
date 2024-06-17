//
//  MainViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit
import Alamofire

final class SearchViewController: UIViewController {
    
    private let user = UserDefaultManager.shared
    
    lazy private var list: [String] = user.mySearchList
    
    lazy private var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarTextDidChange), for: .editingChanged)
        
        return searchBar
    }()
    
    private let topLineView = LineView()
    
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
    
    lazy private var deleteAllButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.point, for: .normal)
        button.titleLabel?.font = ViewConstant.Font.normal13
        button.addTarget(self, action: #selector(deleteAllButtonClicked), for: .touchUpInside)
        
        return button
    }()

    private let tableView = UITableView()
    
    private let bottomLineView = LineView()
    
    var responseList = Search(lastBuildDate: "",
                              total: 0,
                              start: 0,
                              display: 0,
                              items: [])
    
    lazy private var tapGesture = UITapGestureRecognizer(target: self, action: #selector(anyTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(user.nickName)'s See The Good"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        
        searchBar.delegate = self
        
        configureView()
        
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        responseList = Search(lastBuildDate: "",
                              total: 0,
                              start: 0,
                              display: 0,
                              items: [])
        list = user.mySearchList
        configureWhichView()
        tableView.reloadData()
    }
    
    private func configureView() {
        tapGesture.cancelsTouchesInView = false // 모든 터치를 전달 받도록 해주는 속성
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(searchBar)
        view.addSubview(topLineView)
        configureWhichView()
        view.addSubview(bottomLineView)
        
        configureLayout()
    }

    private func configureWhichView() {
        if list.isEmpty {
            configureEmptyView()
        } else {
            configureNotEmptyView()
        }
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
    
    @objc private func deleteAllButtonClicked() {
        UserDefaults.standard.removeObject(forKey: "mySearchList")
        list = user.mySearchList
        configureWhichView()
        tableView.reloadData()
    }
    
    @objc private func anyTapped() {
        searchBar.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let target = searchBar.text else { return }
        
        user.mySearchList.append(target)
        tableView.reloadData()
        
        let vc = SearchResultViewController()
        vc.searchWord = target
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        cell.searchRecordLabel.text = list.reversed()[indexPath.row]
        cell.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        cell.xButton.tag = indexPath.row
        
        if let targetText = searchBar.text, !targetText.isEmpty, let listText = cell.searchRecordLabel.text {
            cell.searchRecordLabel.setHighlighted(listText, with: targetText)
        }
        
        return cell
    }
    
    @objc func searchBarTextDidChange(_ searchBar: UISearchBar) {
        guard let target = searchBar.text else { return }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let target = list.reversed()[indexPath.row]
        let vc = SearchResultViewController()
        
        vc.searchWord = target
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func xButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        var mySearchList = user.mySearchList
        mySearchList.remove(at: mySearchList.count - index - 1)
        user.mySearchList = mySearchList
        list = user.mySearchList
        configureWhichView()
        tableView.reloadData()
    }
}
