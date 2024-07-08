//
//  BasketListCollectionViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import UIKit

final class BasketListCollectionViewCell: BaseCollectionViewCell {
    
    var lastItemimageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 8
        
        return view
    }()
     
    var categoryTitleLable = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        
        return label
    }()

    override func configureHierarchy() {
        contentView.addSubview(lastItemimageView)
        contentView.addSubview(categoryTitleLable)
    }
    
    override func configureLayout() {
        lastItemimageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        
        categoryTitleLable.snp.makeConstraints { make in
            make.top.equalTo(lastItemimageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
        }
    }
    
    override func configureView() {
        
    }
}
