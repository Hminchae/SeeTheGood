//
//  ViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let appNameLabel = {
        let label = UILabel()
        label.text = "SeeTheGood"
        label.font = .systemFont(ofSize: 40, weight: .black)
        label.textColor = .point
        label.textAlignment = .center
    
        return label
    }()
    
    private let onboardingImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launch")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // 커스텀 버튼 만들기
    lazy private var startButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = ViewConstant.Font.heavy16
        button.layer.cornerRadius = ViewConstant.Radius.orangeButton
        button.backgroundColor = .point
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureView()
    }
    
    private func configureView() {
        view.addSubview(appNameLabel)
        view.addSubview(onboardingImageView)
        view.addSubview(startButton)
        
        configureLayout()
    }
    
    private func configureLayout() {
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(145)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.height.equalTo(60)
        }
        
        onboardingImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(50)
        }
    }
    
    @objc private func startButtonClicked() {
        let vc = ProfileSettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

