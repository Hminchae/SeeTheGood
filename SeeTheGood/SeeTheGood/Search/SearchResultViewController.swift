//
//  SearchResultViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher

class SearchResultViewController: UIViewController {
    
    var searchWord: String?
    var sortWay: String = "sim"
    var page = 1
    
    lazy var currentSearchQueryTotalPage: Int = {
        if responseList.display != 0 {
            return responseList.total / responseList.display
        }
        return 0
    }()
    
    var isEnd: Bool { // page 가 토탈 페이지에 도달했을 때
        get {
            return currentSearchQueryTotalPage == page ? true : false
        }
    }
    
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
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy private var sortSimButton = selectedButtonSet("정확도")
    lazy private var sortDateButton = unSelectedButtonSet("날짜순")
    lazy private var sortDscButton = unSelectedButtonSet("가격높은순")
    lazy private var sortAscButton = unSelectedButtonSet("가격낮은순")
    
    lazy private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
        configureAsyncTask()
        configureStackView()
        configureCollectionView()
        configureView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    private func configureView() {
        view.addSubview(topLineView)
        view.addSubview(totalSearchResultLabel)
        view.addSubview(sortStackView)
        view.addSubview(collectionView)
        
        configureLayout()
    }
    
    private func configureLayout() {
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
            make.trailing.lessThanOrEqualTo(view.snp.trailing).inset(UIScreen.main.bounds.width - 310)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func configureAsyncTask() {
        if let target = searchWord {
            navigationItem.title = target
            Task {
                await callRequest(query: target, sort: "sim", page: page)
            }
        }
    }
    
    private func configureStackView() {
        sortStackView.addArrangedSubview(sortSimButton)
        sortStackView.addArrangedSubview(sortDateButton)
        sortStackView.addArrangedSubview(sortDscButton)
        sortStackView.addArrangedSubview(sortAscButton)
        
        sortSimButton.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        
        sortDateButton.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        
        sortDscButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        sortAscButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    private func selectedButtonSet(_ title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .firstGray
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = ViewConstant.Font.normal14
        
        return button
    }
    
    private func unSelectedButtonSet(_ title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = ViewConstant.Font.normal14
        button.layer.borderColor = UIColor.thirdGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        
        return button
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 6
        let cellSpacing: CGFloat = 14
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: width/2, height: width * 0.85)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing,
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
        
        return layout
    }
}

// 네트워크
extension SearchResultViewController {
    
    func callRequest(query: String, sort: String, page: Int) async {
        let url = "\(APIKey.url.rawValue)?query=\(query)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID.rawValue,
            "X-Naver-Client-Secret": APIKey.clientSecret.rawValue
        ]
        let para: Parameters = [
            "query": query,
            "sort": sort,
            "page": page,
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: para,
                   headers: header).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.responseList.items.append(contentsOf: value.items)
                self.totalSearchResultLabel.text = "\(value.total)개의 검색 결과"
                self.collectionView.reloadData()
            case .failure(let error):
                print("Failed")
                print(error)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        print(responseList)
        print(responseList.items.count)
        return responseList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let data = responseList.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        let imageUrl = URL(string: data.image)
        cell.mainImageView.kf.setImage(with: imageUrl)
        cell.mallNameLabel.text = data.mallName
        cell.productTitle.text = cleanText(data.title)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        cell.productPriceLabel.text = formatStrToMoney(data.lprice)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func cleanText(_ text: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<[^>]+>", options: [])
        var cleanText = regex.stringByReplacingMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count), withTemplate: "")
        
        cleanText = cleanText.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
        
        cleanText = cleanText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleanText
    }
    
    func formatStrToMoney(_ price: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let number = Int(price) {
            return "\(formatter.string(from: NSNumber(value: number)) ?? price)원"
        } else {
            return price 
        }
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if responseList.items.count - 2 == indexPath.row && !isEnd {
                page += 1
                Task {
                    if let searchWord = searchWord {
                        await callRequest(query: searchWord, sort: sortWay, page: page)
                    }
                    print(page)
                }
            }
        }
    }
    
    // 취소기능
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소", indexPaths)
        indexPaths.forEach { indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCollectionViewCell {
                cell.mainImageView.kf.cancelDownloadTask()
            }
        }
    }
}
