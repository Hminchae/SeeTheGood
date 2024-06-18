//
//  ProfileImageSettingViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

import SnapKit

final class ProfileImageSettingViewController: UIViewController {
    
    var selectedImageNum: Int? = nil
    var onImageSelect: ((Int) -> Void)?
    
    private let lineView = LineView()
    
    lazy private var profileImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.point.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profile_\(selectedImageNum!)")
        
        return imageView
    }()
    
    private let profileCameraCircleView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .point
        
        return view
    }()
    
    private let profileCameraCircleImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PROFILE SETTING"
        view.backgroundColor = .white
        configureCollectionView()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(lineView)
        view.addSubview(profileImageView)
        view.addSubview(profileCameraCircleView)
        view.addSubview(collectionView)
        
        configureCameraCircleView()
        configureLayout()
    }
    
    private func configureCameraCircleView() {
        profileCameraCircleView.addSubview(profileCameraCircleImageView)
        
        profileCameraCircleImageView.snp.makeConstraints { make in
            make.edges.equalTo(profileCameraCircleView.snp.edges).inset(5)
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    private func configureLayout() {
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(25)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(100)
        }
        
        profileCameraCircleView.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            //make.centerX.equalTo(view.snp.centerX)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
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

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        
        if indexPath.row == selectedImageNum {
            cell.profileImage.image = UIImage(named: "profile_\(indexPath.row)")
            cell.profileImage.alpha = 1.0
            cell.profileImage.layer.borderColor = UIColor.point.cgColor
            cell.profileImage.layer.borderWidth = ViewConstant.BorderWidth.selectedProfile
        } else {
            cell.profileImage.image = UIImage(named: "profile_\(indexPath.row)")
            cell.profileImage.alpha = 0.5
            cell.profileImage.layer.borderColor = UIColor.thirdGray.cgColor
            cell.profileImage.layer.borderWidth = ViewConstant.BorderWidth.unSelectedProfile
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageNum = indexPath.row
        collectionView.reloadData()
        profileImageView.image = UIImage(named: "profile_\(indexPath.row)")
        onImageSelect?(indexPath.row)
    }
}

