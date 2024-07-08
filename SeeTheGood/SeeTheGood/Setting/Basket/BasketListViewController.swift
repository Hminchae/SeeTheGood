//
//  BasketListViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import UIKit

import Kingfisher

final class BasketListViewController: BaseViewController {
    
    private let repository = BasketRepository()
    
    var list: [BasketCategory] = []
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasketListCollectionViewCell.self, forCellWithReuseIdentifier: BasketListCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    override func configureView() {
        navigationItem.title = "나의 장바구니 목록"
        configureList()
    }
    
    private func configureList() {
        list = repository.fetchCategory()
        
        collectionView.reloadData()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let numberOfColumns: CGFloat = 2
        
        let totalHorizontalSpacing = (sectionSpacing * 2) + (cellSpacing * (numberOfColumns - 1))
        let cellWidth = (UIScreen.main.bounds.width - totalHorizontalSpacing) / numberOfColumns
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
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

extension BasketListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketListCollectionViewCell.identifier, for: indexPath)
        guard let cell = cell as? BasketListCollectionViewCell else { return UICollectionViewCell() }
        
        let data = list[indexPath.row]
        
        cell.categoryTitleLable.text = data.categoryTitle
        
        if let url = data.productList.first?.imageUrl {
            let imageUrl = URL(string: url)
            cell.lastItemimageView.kf.setImage(with: imageUrl)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = Array(list[indexPath.row].productList)
        
        let vc = BasketListDetailViewController()
        vc.list = data
        
        vc.viewTitle = list[indexPath.row].categoryTitle
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
