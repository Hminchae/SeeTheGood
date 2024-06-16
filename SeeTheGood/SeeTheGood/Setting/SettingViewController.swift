//
//  SettingViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

final class SettingViewController: UIViewController {
    
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
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
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
        switch indexPath.section {
        case 0:
            defer {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            let vc = ProfileSettingViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            defer {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            switch indexPath.row {
            case 0:
                print("후엥")
            case 1:
                print("우웩")
            case 2:
                print("우웩")
            case 3:
                print("우웩")
            case 4:
                print("우웩")
            default:
                fatalError("error")
            }
        default:
            fatalError("error")
        }
    }
}


