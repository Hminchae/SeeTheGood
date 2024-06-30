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

// 설정 리스트
enum SettingList: String, CaseIterable {
    case basketList = "나의 장바구니 목록"
    case fnq = "자주 묻는 질문"
    case question = "1:1 문의"
    case notiSetting = "알림 설정"
    case withdraw = "탈퇴하기"
}

// 네트워크 에러
enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

// 닉네임 유효성 검사
enum ValidationError: Error {
    case invalidLength
    case containsUnwantedCharacters
    case containsDigits
    
    var message: String {
        switch self {
        case .invalidLength:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .containsUnwantedCharacters:
            return "닉네임에 @,#,$,% 는 포함할 수 없어요"
        case .containsDigits:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}
