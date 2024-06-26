//
//  SearchResultCollectionViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

import SkeletonView

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    let mainImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.isSkeletonable = true
        
        return imageView
    }()
    
    let basketButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.isSkeletonable = true
        return button
    }()
    
    let mallNameLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.normal13
        label.textColor = .secondGray
        label.textAlignment = .left
        label.isSkeletonable = true
        return label
    }()
    
    let productTitle = {
        let label = UILabel()
        label.font = ViewConstant.Font.semibold14
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.isSkeletonable = true
        return label
    }()
    
    let productPriceLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.heavy15
        label.textColor = .black
        label.textAlignment = .left
        label.isSkeletonable = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        contentView.addSubview(mainImageView)
        contentView.addSubview(basketButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(productTitle)
        contentView.addSubview(productPriceLabel)
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
        }
        
        basketButton.snp.makeConstraints { make in
            make.trailing.equalTo(mainImageView).inset(10)
            make.bottom.equalTo(mainImageView).inset(10)
            make.size.equalTo(30)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.height.equalTo(15)
        }
        
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(5).priority(.high)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.height.equalTo(19)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
