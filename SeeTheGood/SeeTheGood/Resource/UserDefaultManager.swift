//
//  UserDefaultManager.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import Foundation

/*
 ✅ 유저가 가져야할 것
 - 닉네임
 - 프로필 사진 넘버
 - 초기 셋팅 여부
 - 가입 날짜
 - 장바구니 아이템 ID 배열(순서 상관x)
 - 검색어 list(순서 상관O, 중복 허용x)
 */

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() { }
    
    var nickName: String {
        get {
            return UserDefaults.standard.string(forKey: "nickName") ?? "사용자"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickName")
        }
    }
    
    var profileImageNum: Int {
        get {
            return UserDefaults.standard.integer(forKey: "profileImageNum")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "profileImageNum")
        }
    }
    
    var didInitialSetting: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "didInitialSetting")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "didInitialSetting")
        }
    }
    
    var signUpDate: String {
        get {
            return UserDefaults.standard.string(forKey: "signUpDate") ?? "가입정보없음"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "signUpDate")
        }
    }
    
    var basketItems: [String] {
        get {
            return UserDefaults.standard.array(forKey: "basketItems") as? [String] ?? []
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "basketItems")
        }
    }
    
    var mySearchList: [String] {
        get {
            return UserDefaults.standard.array(forKey: "mySearchList") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mySearchList")
        }
    }
}
