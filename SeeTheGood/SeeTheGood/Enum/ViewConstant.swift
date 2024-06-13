//
//  ViewStyle.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

enum ViewConstant {
    enum Font {
        static let normal13 = UIFont.systemFont(ofSize: 13)
        static let normal14 = UIFont.systemFont(ofSize: 14)
        static let normal15 = UIFont.systemFont(ofSize: 15)
        static let normal16  = UIFont.systemFont(ofSize: 16)
        
        static let bold13 = UIFont.boldSystemFont(ofSize: 13)
        static let bold14 = UIFont.boldSystemFont(ofSize: 14)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let bold16  = UIFont.boldSystemFont(ofSize: 16)
        
        static let heavy15 = UIFont.systemFont(ofSize: 15, weight: .heavy)
        static let heavy16  = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
    
    enum BorderWidth {
        static let selectedProfile = 3
        static let unSelectedProfile = 1
    }
}
