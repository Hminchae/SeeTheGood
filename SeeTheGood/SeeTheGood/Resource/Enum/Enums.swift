//
//  Enums.swift
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
        
        static let semibold13 = UIFont.systemFont(ofSize: 13, weight: .semibold)
        static let semibold14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
        static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let semibold16  = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        static let bold13 = UIFont.boldSystemFont(ofSize: 13)
        static let bold14 = UIFont.boldSystemFont(ofSize: 14)
        static let bold15 = UIFont.boldSystemFont(ofSize: 15)
        static let bold16  = UIFont.boldSystemFont(ofSize: 16)
        
        static let heavy15 = UIFont.systemFont(ofSize: 15, weight: .heavy)
        static let heavy16  = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
    
    enum BorderWidth {
        static let selectedProfile: CGFloat = 3
        static let unSelectedProfile: CGFloat = 1
    }
    
    enum Radius {
        static let orangeButton: CGFloat = 25
    }
    
    enum OrangeBtnTextStyle: String {
        case start = "시작하기"
        case complete = "완료"
    }
}

// 검색 결과 정렬
enum SortType: Int {
    case sim = 0
    case date
    case dsc
    case asc
}