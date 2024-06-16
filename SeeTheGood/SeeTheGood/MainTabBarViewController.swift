//
//  MainTabBarViewController.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .point
        tabBar.barTintColor = .secondGray
        tabBar.isTranslucent = false
        
        let vc1 = SearchViewController()
        let search = UINavigationController(rootViewController: vc1)
        search.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let vc2 = SettingViewController()
        let setting = UINavigationController(rootViewController: vc2)
        setting.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        let appearance = UITabBarAppearance()
        
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
                // set tabbar opacity
                tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        setViewControllers([search, setting], animated: true)
    }
}
