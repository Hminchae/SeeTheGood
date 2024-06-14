//
//  SearchTableViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit

class SearchTableViewCell: UITableViewCell {

    private let clockIconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        
        return imageView
    }()
    
    private let searchRecordLabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    private let xButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubview(clockIconImageView)
        contentView.addSubview(searchRecordLabel)
        contentView.addSubview(xButton)
        
        configureLayout()
    }
    
    private func configureLayout() {
        clockIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerX)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.size.equalTo(15)
        }
        
        searchRecordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerX)
            make.leading.equalTo(clockIconImageView.snp.trailing).offset(15)
            make.height.equalTo(15)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerX)
            make.leading.equalTo(searchRecordLabel.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.size.equalTo(15)
        }
    }
}
