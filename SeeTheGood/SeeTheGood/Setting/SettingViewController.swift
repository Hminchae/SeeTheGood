//
//  SettingViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

final class SettingViewController: UIViewController {
    
    private let user = UserDefaultManager.shared
    
    private let topLineView = LineView()
    
    private let tableView = UITableView()
    
    private let bottomLineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: UserProfileTableViewCell.identifier)
        tableView.register(SettingListTableViewCell.self, forCellReuseIdentifier: SettingListTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .secondGray
    
        configureView()
    }
    
    private func configureView() {
        navigationItem.title = "SETTING"
        view.addSubview(tableView)
        view.addSubview(topLineView)
        view.addSubview(bottomLineView)
        
        configureLayout()
    }
    
    private func configureLayout() {
        topLineView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return SettingList.allCases.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as! UserProfileTableViewCell
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingListTableViewCell.identifier, for: indexPath) as! SettingListTableViewCell

            if indexPath.row == 0 {
                cell.selectionStyle = .none
                cell.configureFirstCell()
                cell.productCountLabel.text = "158개"
                cell.productLabel.text = "의 상품"
            }
            cell.listTitleLabel.text = SettingList.allCases[indexPath.row].rawValue
            
            return cell
        default:
            fatalError("error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        defer {
            if indexPath != [1, 0] {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        switch indexPath.section {
        case 0:
            let vc = ProfileSettingViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            switch indexPath.row {
            case 0:
                print(indexPath.row )
            case 1:
                print(indexPath.row )
            case 2:
                print(indexPath.row )
            case 3:
                print(indexPath.row )
            case 4:
                alertWithdraw()
            default:
                fatalError("error")
            }
        default:
            fatalError("error")
        }
    }
    
    func alertWithdraw() {
        let alert = UIAlertController(
            title: "탈퇴하기",
            message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
            preferredStyle: .alert)
        
        let confirm = UIAlertAction(
            title: "확인",
            style: .default) { action in
                self.user.nickName = "사용자"
                self.user.profileImageNum = 0
                self.user.didInitialSetting = false
                self.user.signUpDate = "가입정보없음"
                self.popTheOnboardingView()
            }
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    func popTheOnboardingView() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}


