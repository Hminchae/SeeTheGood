//
//  ModifyProfileViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/16/24.
//

import UIKit

final class ModifyProfileViewController: UIViewController {

    private let topLineView = LineView()
    
    private let tableView = UITableView()
    
    private let bottomLineView = LineView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        configureView()
    }
    
    private func configureView() {
        navigationItem.title = "SETTING"
        view.addSubview(topLineView)
        
        
        view.addSubview(bottomLineView)
        configureLayout()
    }
    
    private func configureLayout() {
        topLineView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
    }
}
