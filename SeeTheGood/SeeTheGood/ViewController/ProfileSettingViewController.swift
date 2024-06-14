//
//  ProfileSettingViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

import SnapKit

final class ProfileSettingViewController: UIViewController {
    
    private let selectedImageNum = Int.random(in: 0...11)
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .thirdGray
        
        return view
    }()
    
    lazy private var profileImageView = {
        let imageView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        imageView.layer.borderWidth = ViewConstant.BorderWidth.selectedProfile
        imageView.layer.borderColor = UIColor.point.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        imageView.image = UIImage(named: "profile_\(selectedImageNum)")
        
        return imageView
    }()
    
    private var cameraButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        button.backgroundColor = .point
        button.setImage(UIImage(systemName: "camera.fill", withConfiguration: imageConfig), for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    private let nickNameTextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = ViewConstant.Font.bold15
        textField.setPlaceholderColor(.lightGray)
        
        return textField
    }()
    
    private let commentLabel = {
        let label = UILabel()
        label.text = "닉네임에 @는 포함할 수 없어요."
        label.font = ViewConstant.Font.normal13
        label.textColor = .point
        
        return label
    }()
    
    private let completeButton = OrangeButton(style: .complete)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "PROFILE SETTING"
        
        self.navigationController?.navigationBar.tintColor = .black
        print(selectedImageNum)
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBottomBorderToTextField(textField: nickNameTextField)
    }
    
    private func configureView() {
        view.addSubview(lineView)
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(nickNameTextField)
        view.addSubview(commentLabel)
        view.addSubview(completeButton)
        
        configureLayout()
    }
    
    private func configureLayout() {
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(100)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.size.equalTo(30)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(25)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(15)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func addBottomBorderToTextField(textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0,
                              y: textField.frame.size.height - 1,
                              width: textField.frame.width,
                              height: 1)
        border.backgroundColor = UIColor.thirdGray.cgColor
        textField.layer.addSublayer(border)
    }
    
    @objc private func profileImageClicked() {
        let vc = ProfileImageSettingViewController()
        vc.selectedImageNum = selectedImageNum
        navigationController?.pushViewController(vc, animated: true)
    }
}
