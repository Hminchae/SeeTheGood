//
//  SettingListTableViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/16/24.
//

import UIKit

import SnapKit

final class SettingListTableViewCell: UITableViewCell {
    
    var isFirstCell: Bool?
    
    var listTitleLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.normal15
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    var basketIconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "like_selected")
        
        return imageView
    }()
    
    var productCountLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.bold15
        label.textColor = .black
        
        return label
    }()
    
    var productLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.normal15
        label.textColor = .black
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNormalCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNormalCell() {
        contentView.addSubview(listTitleLabel)
        
        listTitleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(15)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(150)
        }
    }
    
    func configureFirstCell() {
        contentView.addSubview(basketIconImageView)
        contentView.addSubview(productCountLabel)
        contentView.addSubview(productLabel)
        
        productLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
        }
        
        productCountLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(15)
            make.trailing.equalTo(productLabel.snp.leading)
        }
        
        basketIconImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(15)
            make.trailing.equalTo(productCountLabel.snp.leading).offset(-5)
            make.size.equalTo(20).priority(.high)
        }
    }
}
