//
//  UserProfileTableViewCell.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/16/24.
//

import UIKit

import SnapKit

final class UserProfileTableViewCell: UITableViewCell {
    
    private let user = UserDefaultManager.shared
    
    var profileImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.point.cgColor
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var userInfoView = UIView()
    
    var userNicknameLabel = {
        let label = UILabel()
        label.font = ViewConstant.Font.heavy16
        label.textColor = .black
        
        return label
    }()
    
    lazy private var userSignUpDateLabel = {
        let label = UILabel()
        label.text = "\(user.signUpDate) 가입"
        label.font = ViewConstant.Font.normal13
        label.textColor = .secondGray
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userInfoView)
        
        configureUserInfoView()
        configureLayout()
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(20)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.size.equalTo(80).priority(.high)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(40)
        }
    }
    
    private func configureUserInfoView() {
        userInfoView.addSubview(userNicknameLabel)
        userInfoView.addSubview(userSignUpDateLabel)
        
        userNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.top)
            make.horizontalEdges.equalTo(userInfoView.snp.horizontalEdges)
            make.height.equalTo(20)
        }
        
        userSignUpDateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNicknameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(userInfoView.snp.horizontalEdges)
            make.bottom.equalTo(userInfoView.snp.bottom)
        }
    }
}
