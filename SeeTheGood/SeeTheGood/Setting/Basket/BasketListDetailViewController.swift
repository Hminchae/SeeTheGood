//
//  BasketListDetailViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import UIKit

import SkeletonView

final class BasketListDetailViewController: BaseViewController {
    
    var list: [BasketTable] = []
    var viewTitle: String?
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    override func configureView() {
        if let viewTitle {
            navigationItem.title = viewTitle
        }
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

extension BasketListDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath)
        guard let cell = cell as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        
        let data = list[indexPath.row]
        
        cell.basketButton.isHidden = true
        cell.productTitle.text = data.title
        cell.mallNameLabel.text = data.mallName
        cell.productPriceLabel.text = data.price
        
        let imageUrl = URL(string: data.imageUrl)
        cell.mainImageView.kf.setImage(with: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchDetailViewController()
        let data = list[indexPath.row]
        
        vc.link = data.link
        vc.productTitle = data.title.cleanHTMLTags()
        vc.productId = data.productNum
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
