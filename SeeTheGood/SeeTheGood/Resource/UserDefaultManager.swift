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
 -
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
}
