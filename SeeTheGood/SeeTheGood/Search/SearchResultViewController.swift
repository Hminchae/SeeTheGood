//
//  SearchResultViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class SearchResultViewController: UIViewController {
    
    var searchWord: String?
    var page = 1
    var basketDictionary: [String: Bool] = [:]
    var currentSortType: SortType = .sim
    
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
    
    lazy private var sortButtons: [UIButton] = [
        buttonSet("정확도", tag: SortType.sim.rawValue),
        buttonSet("날짜순", tag: SortType.date.rawValue),
        buttonSet("가격높은순", tag: SortType.dsc.rawValue),
        buttonSet("가격낮은순", tag: SortType.asc.rawValue)
    ]
    
    lazy private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private let bottomLineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black

        configureAsyncTask()
        configureStackView()
        configureSortButtons()
        configureCollectionView()
        configureView()
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    private func configureView() {
        view.addSubview(topLineView)
        view.addSubview(totalSearchResultLabel)
        view.addSubview(sortStackView)
        view.addSubview(collectionView)
        view.addSubview(bottomLineView)
        
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
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
    
    private func configureAsyncTask() {
        if let target = searchWord {
            navigationItem.title = target
            Task {
                await callRequest(query: target, sort: "\(SortType.sim)", page: page)
            }
        }
    }
    
    private func configureStackView() {
        sortButtons.forEach { button in
            sortStackView.addArrangedSubview(button)
        }
        
        sortButtons[0].snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        
        sortButtons[1].snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        
        sortButtons[2].snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        sortButtons[3].snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    private func buttonSet(_ title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderColor = UIColor.thirdGray.cgColor
        button.layer.borderWidth = 1
        button.tag = tag
        button.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
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
    
    private func configureSortButtons() {
        print(#function)
        sortButtons.forEach { button in
            let isSelected = button.tag == currentSortType.rawValue
            button.backgroundColor = isSelected ? .firstGray : .white
            button.setTitleColor(isSelected ? .white : .black, for: .normal)
        }
    }
    
    @objc func sortButtonClicked(_ sender: UIButton) {
        if let selectedSortType = SortType(rawValue: sender.tag) {
            currentSortType = selectedSortType
            configureSortButtons()
            // 데이터 초기화
            responseList.items.removeAll()
            collectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: true)
            collectionView.reloadData()
            page = 1
            // 네트워크 요청
            if let target = searchWord {
                navigationItem.title = target
                Task {
                    await callRequest(query: target, sort: "\(selectedSortType)", page: page)
                }
            }
        }
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
            "display":30,
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
        responseList.items.count
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
        
        let isBasketClicked = basketDictionary[data.productId] ?? false
        
        cell.basketButton.backgroundColor = isBasketClicked ? .white : .black.withAlphaComponent(0.5)
        cell.basketButton.tintColor = isBasketClicked ? .black : .white
        cell.basketButton.setImage(isBasketClicked ? UIImage(named: "like_selected") : UIImage(named: "like_unselected") , for: .normal)
        cell.basketButton.tag = indexPath.row
        cell.basketButton.addTarget(self, action: #selector(basketButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchDetailViewController()
        let data = responseList.items[indexPath.row]
        
        vc.link = data.link
        vc.productTitle = cleanText(data.title)
        vc.isBasketClicked = basketDictionary[data.productId]
        
        navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func basketButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        
        basketDictionary[responseList.items[index].productId] = !(basketDictionary[responseList.items[index].productId] ?? false)
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if responseList.items.count - 2 == indexPath.row && !isEnd {
                page += 1
                Task {
                    if let searchWord = searchWord {
                        await callRequest(query: searchWord, sort: "\(SortType.sim)", page: page)
                    }
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
