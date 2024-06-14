//
//  ProfileImageSettingViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

class ProfileImageSettingViewController: UIViewController {
    
    var selectedImageNum: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PROFILE SETTING"
        view.backgroundColor = .white
        print(selectedImageNum)
    }
}
