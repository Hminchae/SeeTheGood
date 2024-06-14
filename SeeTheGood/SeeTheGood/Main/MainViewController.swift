//
//  MainViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let user = UserDefaultManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user.nickName)'s See The Good"
        view.backgroundColor = .white

    } 
}
