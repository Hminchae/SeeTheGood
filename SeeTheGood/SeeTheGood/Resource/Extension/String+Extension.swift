//
//  String+Extension.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/30/24.
//

import Foundation

extension String {
    // 닉네임 길이 체크
    func isValidLength(min: Int = 2, max: Int = 10) throws {
        if self.count < min || self.count >= max {
            throw ValidationError.invalidLength
        }
    }
    
    // 특정 문자 포함 여부 체크
    func containsUnwantedCharacters() throws {
        let unwantedChars = CharacterSet(charactersIn: "@#$%")
        if self.rangeOfCharacter(from: unwantedChars) != nil {
            throw ValidationError.containsUnwantedCharacters
        }
    }
    
    // 숫자 포함 여부 체크
    func containsDigits() throws {
        let unwantedIntegers = CharacterSet.decimalDigits
        if self.rangeOfCharacter(from: unwantedIntegers) != nil {
            throw ValidationError.containsDigits
        }
    }
    
    // 전체 유효성 체크
    func validateNickname() throws {
        try isValidLength()
        try containsUnwantedCharacters()
        try containsDigits()
    }
}
