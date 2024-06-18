//
//  ProfileImageCollectionViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit

final class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    var profileImage = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = (UIScreen.main.bounds.width - 75) / 8
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
