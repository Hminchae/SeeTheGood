//
//  SearchResultViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

import Alamofire
import SnapKit

class SearchResultViewController: UIViewController {
    
    var searchWord: String?
    var sortWay: String = "sim"
    
    private var responseList = Search(lastBuildDate: "",
                                      total: 0,
                                      start: 0,
                                      display: 0,
                                      items: [])
    
    private let topLineView = LineView()
    
    private var totalSearchResultLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.bold15
        label.textColor = .point
        
        return label
    }()
    
    private let sortStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy private var sortSimButton = selectedButtonSet("정확도")
    
    func selectedButtonSet(_ title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        
        config.baseBackgroundColor = .clear
        config.attributedTitle = selectedTitleAttribute(title)
        
        button.layer.cornerRadius = 15
        button.backgroundColor = .firstGray
        button.configuration = config
        
        return button
    }
    
    func unSelectedButtonSet(_ title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        
        config.baseBackgroundColor = .clear
        config.attributedTitle = unSelectedTitleAttribute(title)
        
        button.layer.borderColor = UIColor.thirdGray.cgColor
        button.titleLabel?.numberOfLines = 1
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.configuration = config
        
        return button
    }
    
    func selectedTitleAttribute(_ title: String) -> AttributedString {
        let attributes = AttributedString(title, attributes: AttributeContainer([.font: ViewConstant.Font.normal14, .foregroundColor: UIColor.white]))
        return attributes
    }
    
    func unSelectedTitleAttribute(_ title: String) -> AttributedString {
        let attributes = AttributedString(title, attributes: AttributeContainer([.font: ViewConstant.Font.normal14, .foregroundColor: UIColor.black]))
        return attributes
    }
    
    lazy private var sortDateButton = unSelectedButtonSet("날짜순")
    lazy private var sortDscButton = unSelectedButtonSet("가격높은순")
    lazy private var sortAscButton = unSelectedButtonSet("가격낮은순")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
        configureAsyncTask()
        configureStackView()
        configureView()
    }
    
    func configureView() {
        view.addSubview(topLineView)
        view.addSubview(totalSearchResultLabel)
        view.addSubview(sortStackView)
        
        configureLayout()
    }
    
    func configureLayout() {
        topLineView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        totalSearchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(15)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.height.equalTo(20)
        }
        
        sortStackView.snp.makeConstraints { make in
            make.top.equalTo(totalSearchResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).inset(40)
            make.height.equalTo(30)
        }
    }
    
    func configureAsyncTask() {
        if let target = searchWord {
            navigationItem.title = target
            Task {
                if let value = await callRequest(query: target, sort: "sim") {
                    responseList = value
                    totalSearchResultLabel.text = "\(responseList.total)개의 검색 결과"
                }
            }
        }
    }
    
    func configureStackView() {
        sortStackView.addArrangedSubview(sortSimButton)
        sortStackView.addArrangedSubview(sortDateButton)
        sortStackView.addArrangedSubview(sortDscButton)
        sortStackView.addArrangedSubview(sortAscButton)
    }
}

// 네트워크
extension SearchResultViewController {
    
    func callRequest(query: String, sort: String) async -> Search? {
        let url = "\(APIKey.url.rawValue)?query=\(query)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID.rawValue,
            "X-Naver-Client-Secret": APIKey.clientSecret.rawValue
        ]
        let para: Parameters = [
            "query": query,
            "sort": sort
        ]
        do {
            let response = try await AF.request(url,
                                                method: .get,
                                                parameters: para,
                                                headers: header)
                .serializingDecodable(Search.self).value
            return response
        } catch {
            print("네트워크 오류")
            return nil
        }
    }
}
